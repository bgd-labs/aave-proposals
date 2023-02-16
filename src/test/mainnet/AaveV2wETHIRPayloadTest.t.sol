// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';
import {ProtocolV2TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2wETHIRPayload} from '../../contracts/mainnet/AaveV2wETHIRPayload.sol';

contract AaveV2wETHIRPayloadE2ETest is ProtocolV2TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  uint256 public proposalId;
  IDefaultInterestRateStrategy public constant OLD_INTEREST_RATE_STRATEGY_ETHEREUM =
    IDefaultInterestRateStrategy(AaveV2EthereumAssets.WETH_INTEREST_RATE_STRATEGY);

  address public NEW_INTEREST_RATE_STRATEGY;
  IDefaultInterestRateStrategy public strategy;
  AaveV2wETHIRPayload public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16620283);

    proposalPayload = new AaveV2wETHIRPayload();
    NEW_INTEREST_RATE_STRATEGY = proposalPayload.INTEREST_RATE_STRATEGY();
    strategy = IDefaultInterestRateStrategy(NEW_INTEREST_RATE_STRATEGY);
  }

  function testExecute() public {
    createConfigurationSnapshot('pre-AaveV2Ethereum-interestRateUpdate', AaveV2Ethereum.POOL);

    ReserveConfig[] memory allConfigsEthereumBefore = _getReservesConfigs(AaveV2Ethereum.POOL);
    ReserveConfig memory configWethBefore = _findReserveConfig(
      allConfigsEthereumBefore,
      AaveV2EthereumAssets.WETH_UNDERLYING
    );

    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
    _executePayload(address(proposalPayload));

    // Post-execution assertations
    ReserveConfig[] memory allConfigsEthereum = _getReservesConfigs(AaveV2Ethereum.POOL);

    configWethBefore.interestRateStrategy = proposalPayload.INTEREST_RATE_STRATEGY();

    _validateReserveConfig(configWethBefore, allConfigsEthereum);

    _validateInterestRateStrategy(
      configWethBefore.interestRateStrategy,
      AaveV2wETHIRPayload(proposalPayload).INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        baseVariableBorrowRate: 1 * (RAY / 100),
        stableRateSlope1: OLD_INTEREST_RATE_STRATEGY_ETHEREUM.stableRateSlope1(),
        stableRateSlope2: OLD_INTEREST_RATE_STRATEGY_ETHEREUM.stableRateSlope2(),
        variableRateSlope1: 38 * (RAY / 1000),
        variableRateSlope2: 80 * (RAY / 100)
      })
    );

    createConfigurationSnapshot('post-AaveV2Ethereum-interestRateUpdate', AaveV2Ethereum.POOL);
  }

  function testUtilizationAtZeroPercent() public {
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      100 * 1e18,
      0,
      0,
      68200000000000000000000000,
      2000
    );

    // At nothing borrowed, liquidity rate should be 0, variable rate should be 1% and stable rate should be 3%.
    assertEq(liqRate, 0);
    assertEq(stableRate, 3 * (RAY / 100));
    assertEq(varRate, 1 * (RAY / 100));
  }

  function testUtilizationAtOneHundredPercent() public {
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      0,
      0,
      100 * 1e18,
      68200000000000000000000000,
      2000
    );

    // At max borrow rate, stable rate should be 87% and variable rate should be 84.8%.
    assertEq(liqRate, 678400000000000000000000000);
    assertEq(stableRate, 87 * (RAY / 100));
    assertEq(varRate, 848 * (RAY / 1000));
  }

  function testUtilizationAtUOptimal() public {
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      30 * 1e18,
      0,
      70 * 1e18,
      68200000000000000000000000,
      2000
    );

    // At UOptimal, stable rate should be 6.5% and variable rate should be 4.325%.
    assertEq(liqRate, 24220000000000000000000000);
    assertEq(stableRate, 65 * (RAY / 1000));
    assertEq(varRate, 4325 * (RAY / 100000));
  }
}
