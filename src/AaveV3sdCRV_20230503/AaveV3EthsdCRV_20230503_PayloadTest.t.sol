// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

import {AaveV3EthsdCRV_20230503_Payload} from './AaveV3EthsdCRV_20230503_Payload.sol';

interface ILiquidityGauge {
  function balanceOf(address user) external returns (uint256);
  function withdraw(uint256 value, bool claimRewards) external;
}

/// @notice sdCRV addresses: https://stakedao.gitbook.io/stakedaohq/platform/liquid-lockers/sdtokens/crv-liquid-locker
/// @notice Deposit and Stake: https://stakedao.gitbook.io/stakedaohq/tutorials/liquid-lockers/deposit-and-stake-in-liquid-lockers
contract AaveV3EthsdCRV_20230503_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  address public constant SD_CRV_GAUGE = 0x7f50786A0b15723D741727882ee99a0BF34e3466;
  address public constant SD_CRV = 0xD1b5651E55D4CeeD36251c61c50C889B36F6abB5;
  AaveV3EthsdCRV_20230503_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17219011);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3EthsdCRV_20230503_Payload();
  }

  function testExecute() public {
    // Pre-execution balances of CRV and aCRV
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      19714118888439666456840
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      754275831989801164278616
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      1181006913494914193094
    );
    // End Pre-execution balances of CRV and aCRV

    ILiquidityGauge gauge = ILiquidityGauge(SD_CRV_GAUGE);
    uint256 gaugeBalanceBefore = IERC20(SD_CRV).balanceOf(SD_CRV_GAUGE);

    _executePayload(address(payload));

    // Post-execution balances of CRV and aCRV
    // Collector contract will have no CRV and only a limited amount of aCRV left
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      21842224941228746535 // Normal to have some left over when withdrawing aTokens
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      0 // Normal to have some left over when withdrawing aTokens
    );

    // Because we are staking the sdCRV, the Collector will receive 0 sdCRV, but will have a balance of
    // the minted amount in the sdCRV Gauge controller: 

    assertEq(IERC20(SD_CRV).balanceOf(SD_CRV_GAUGE), gaugeBalanceBefore + 775_173_153374537761473241);
    assertEq(IERC20(SD_CRV).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 0);
    assertEq(gauge.balanceOf(address(AaveV2Ethereum.COLLECTOR)), 775_173_153374537761473241);

    // Pretend to be Collector and try to withdraw sdCRV from gauge
    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    gauge.withdraw(100_000e18, false);
    vm.stopPrank();

    assertEq(IERC20(SD_CRV).balanceOf(SD_CRV_GAUGE), gaugeBalanceBefore + 775_173_153374537761473241 - 100_000e18);
    assertEq(IERC20(SD_CRV).balanceOf(address(AaveV2Ethereum.COLLECTOR)), 100_000e18);
    assertEq(gauge.balanceOf(address(AaveV2Ethereum.COLLECTOR)), 775_173_153374537761473241 - 100_000e18);

    // End Post-execution balances of CRV and aCRV
  }
}
