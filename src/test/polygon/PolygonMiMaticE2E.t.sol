// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {IStateReceiver} from 'governance-crosschain-bridges/contracts/dependencies/polygon/fxportal/FxChild.sol';
import {CrosschainForwarderPolygon} from '../../contracts/polygon/CrosschainForwarderPolygon.sol';
import {MiMaticPayload} from '../../contracts/polygon/MiMaticPayload.sol';
import {DeployL1PolygonProposal} from '../../../script/DeployL1PolygonProposal.s.sol';

contract PolygonMiMaticE2ETest is ProtocolV3TestBase {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 polygonFork;

  MiMaticPayload public miMaticPayload;

  address public constant CROSSCHAIN_FORWARDER_POLYGON =
    0x158a6bC04F0828318821baE797f50B0A1299d45b;
  address public constant BRIDGE_ADMIN =
    0x0000000000000000000000000000000000001001;
  address public constant FX_CHILD_ADDRESS =
    0x8397259c983751DAf40400790063935a11afa28a;
  address public constant POLYGON_BRIDGE_EXECUTOR =
    0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772;

  address public constant MIMATIC = 0xa3Fa99A148fA48D14Ed51d610c367C61876997F1;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;

  function setUp() public {
    polygonFork = vm.createFork(vm.rpcUrl('polygon'), 31507646);
    mainnetFork = vm.createFork(vm.rpcUrl('ethereum'), 15275388);
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input)
    public
    pure
    returns (bytes calldata)
  {
    return input[64:];
  }

  function testProposalE2E() public {
    vm.selectFork(polygonFork);

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    // 1. deploy l2 payload
    miMaticPayload = new MiMaticPayload();

    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(GovHelpers.AAVE_WHALE);
    uint256 proposalId = DeployL1PolygonProposal._deployL1Proposal(
      address(miMaticPayload),
      0xf6e50d5a3f824f5ab4ffa15fb79f4fa1871b8bf7af9e9b32c1aaaa9ea633006d
    );
    vm.stopPrank();

    // 3. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('StateSynced(uint256,address,bytes)'),
      entries[2].topics[0]
    );
    assertEq(address(uint160(uint256(entries[2].topics[2]))), FX_CHILD_ADDRESS);

    // 4. mock the receive on l2 with the data emitted on StateSynced
    vm.selectFork(polygonFork);
    vm.startPrank(BRIDGE_ADMIN);
    IStateReceiver(FX_CHILD_ADDRESS).onStateReceive(
      uint256(entries[2].topics[1]),
      this._cutBytes(entries[2].data)
    );
    vm.stopPrank();

    // 5. Forward time & execute proposal
    BridgeExecutorHelpers.waitAndExecuteLatest(vm, POLYGON_BRIDGE_EXECUTOR);

    // 6. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory expectedAssetConfig = ReserveConfig({
      symbol: 'miMATIC',
      underlying: MIMATIC,
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
      supplyCap: 100_000_000,
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
      _findReserveConfigBySymbol(allConfigsAfter, 'miMATIC'),
      ReserveTokens({
        aToken: miMaticPayload.ATOKEN_IMPL(),
        stableDebtToken: miMaticPayload.SDTOKEN_IMPL(),
        variableDebtToken: miMaticPayload.VDTOKEN_IMPL()
      })
    );

    this._validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      MIMATIC,
      miMaticPayload.PRICE_FEED()
    );

    // impl should be same as USDC
    _validateReserveTokensImpls(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      _findReserveConfigBySymbol(allConfigsAfter, 'USDC'),
      ReserveTokens({
        aToken: miMaticPayload.ATOKEN_IMPL(),
        stableDebtToken: miMaticPayload.SDTOKEN_IMPL(),
        variableDebtToken: miMaticPayload.VDTOKEN_IMPL()
      })
    );

    _validatePoolActionsPostListing(allConfigsAfter);
  }

  function _validatePoolActionsPostListing(
    ReserveConfig[] memory allReservesConfigs
  ) internal {
    ReserveConfig memory miMatic = _findReserveConfigBySymbol(
      allReservesConfigs,
      'miMATIC'
    );
    ReserveConfig memory dai = _findReserveConfigBySymbol(
      allReservesConfigs,
      'DAI'
    );

    address user0 = address(1);
    _deposit(miMatic, AaveV3Polygon.POOL, user0, 666 ether);

    // We check revert when trying to borrow (not enabled in isolation)
    try this._borrow(miMatic, AaveV3Polygon.POOL, user0, 10 ether, true) {
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

    _repay(dai, AaveV3Polygon.POOL, user0, 666 ether, false);

    _withdraw(miMatic, AaveV3Polygon.POOL, user0, type(uint256).max);
  }
}
