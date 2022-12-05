// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Polygon, AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {FraxPayload} from '../../contracts/polygon/FraxPayload.sol';
import {BaseTest} from '../utils/BaseTest.sol';

contract PolygonFraxE2ETest is ProtocolV3TestBase, BaseTest {
  // the identifiers of the forks
  uint256 polygonFork;

  FraxPayload public fraxPayload;

  address public constant FRAX = 0x45c32fA6DF82ead1e2EF74d17b76547EDdFaFF89;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;

  function setUp() public {
    polygonFork = vm.createSelectFork(vm.rpcUrl('polygon'), 31507646);
    _setUp(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testProposalE2E() public {
    vm.selectFork(polygonFork);

    // we get all configs to later on check that payload only changes FRAX
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    // 1. deploy l2 payload
    fraxPayload = new FraxPayload();

    // 2. execute l2 payload
    _execute(address(fraxPayload));

    // 3. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory expectedAssetConfig = ReserveConfig({
      symbol: 'FRAX',
      underlying: FRAX,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 7500,
      liquidationThreshold: 8000,
      liquidationBonus: 10500,
      liquidationProtocolFee: 1000,
      reserveFactor: 1000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigsAfter, 'USDT')
        .interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      supplyCap: 50_000_000,
      borrowCap: 0,
      debtCeiling: 2_000_000_00,
      eModeCategory: 1
    });

    _validateReserveConfig(expectedAssetConfig, allConfigsAfter);

    _noReservesConfigsChangesApartNewListings(
      allConfigsBefore,
      allConfigsAfter
    );

    _validateReserveTokensImpls(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      _findReserveConfigBySymbol(allConfigsAfter, 'FRAX'),
      ReserveTokens({
        aToken: fraxPayload.ATOKEN_IMPL(),
        stableDebtToken: fraxPayload.SDTOKEN_IMPL(),
        variableDebtToken: fraxPayload.VDTOKEN_IMPL()
      })
    );

    this._validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      FRAX,
      fraxPayload.PRICE_FEED()
    );

    // impl should be same as USDC
    _validateReserveTokensImpls(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      _findReserveConfigBySymbol(allConfigsAfter, 'USDC'),
      ReserveTokens({
        aToken: fraxPayload.ATOKEN_IMPL(),
        stableDebtToken: fraxPayload.SDTOKEN_IMPL(),
        variableDebtToken: fraxPayload.VDTOKEN_IMPL()
      })
    );

    _validatePoolActionsPostListing(allConfigsAfter);
  }

  function _validatePoolActionsPostListing(
    ReserveConfig[] memory allReservesConfigs
  ) internal {
    ReserveConfig memory frax = _findReserveConfigBySymbol(
      allReservesConfigs,
      'FRAX'
    );
    ReserveConfig memory dai = _findReserveConfigBySymbol(
      allReservesConfigs,
      'DAI'
    );

    address user0 = address(1);
    _deposit(frax, AaveV3Polygon.POOL, user0, 666 ether);

    this._borrow(dai, AaveV3Polygon.POOL, user0, 2 ether, false);

    // We check revert when trying to borrow (not enabled in isolation)
    try this._borrow(frax, AaveV3Polygon.POOL, user0, 300 ether, false) {
      revert('_testProposal() : BORROW_NOT_REVERTING');
    } catch Error(string memory revertReason) {
      require(
        keccak256(bytes(revertReason)) == keccak256(bytes('60')),
        '_testProposal() : INVALID_VARIABLE_REVERT_MSG'
      );
      vm.stopPrank();
    }

    // We check revert when trying to borrow (not enabled in isolation)
    try this._borrow(frax, AaveV3Polygon.POOL, user0, 10 ether, true) {
      revert('_testProposal() : BORROW_NOT_REVERTING');
    } catch Error(string memory revertReason) {
      require(
        keccak256(bytes(revertReason)) == keccak256(bytes('60')),
        '_testProposal() : INVALID_STABLE_REVERT_MSG'
      );
      vm.stopPrank();
    }

    this._borrow(dai, AaveV3Polygon.POOL, user0, 222 ether, false);

    // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
    skip(1);

    _repay(dai, AaveV3Polygon.POOL, user0, 1000 ether, false);

    _withdraw(frax, AaveV3Polygon.POOL, user0, type(uint256).max);
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input)
    public
    pure
    returns (bytes calldata)
  {
    return input[64:];
  }
}
