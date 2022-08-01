// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import 'forge-std/console.sol';
import {Test} from 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

import {GenericPolygonExecutor} from '../src/contracts/polygon/GenericPolygonExecutor.sol';
import {MiMaticPayload} from '../src/contracts/polygon/MiMaticPayload.sol';
import {IStateReceiver} from '../src/interfaces/IFx.sol';
import {IBridgeExecutor} from '../src/interfaces/IBridgeExecutor.sol';
import {DeployL1Proposal} from '../script/DeployL1Proposal.s.sol';
import {AaveV3Helpers, ReserveConfig, ReserveTokens, IERC20} from './helpers/AaveV3Helpers.sol';

contract PolygonMiMaticE2ETest is Test {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 polygonFork;

  MiMaticPayload public miMaticPayload;
  DeployL1Proposal deployl1Proposal;
  address public constant BRIDGE_ADMIN =
    0x0000000000000000000000000000000000001001;
  address public constant FX_CHILD_ADDRESS =
    0x8397259c983751DAf40400790063935a11afa28a;
  address public constant POLYGON_BRIDGE_EXECUTOR =
    0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772;

  address public constant MIMATIC = 0xa3Fa99A148fA48D14Ed51d610c367C61876997F1;
  address public constant MIMATIC_WHALE =
    0x95dD59343a893637BE1c3228060EE6afBf6F0730;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
  address public constant DAI_WHALE =
    0xd7052EC0Fe1fe25b20B7D65F6f3d490fCE58804f;

  function setUp() public {
    polygonFork = vm.createSelectFork('https://polygon-rpc.com', 31237525);
    mainnetFork = vm.createSelectFork('https://rpc.flashbots.net/', 15231241);
    deployl1Proposal = new DeployL1Proposal();
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input) public returns (bytes calldata) {
    return input[64:];
  }

  function testL2ExecuteBridger() public {
    vm.selectFork(polygonFork);
    ReserveConfig[] memory allConfigsBefore = AaveV3Helpers._getReservesConfigs(
      false
    );

    // 0. deploy generic executor
    vm.selectFork(mainnetFork);
    GenericPolygonExecutor bridgeExecutor = new GenericPolygonExecutor(); // TODO: should be replaced with address once deployed

    // 1. deploy l2 payload
    vm.selectFork(polygonFork);
    miMaticPayload = new MiMaticPayload();

    vm.selectFork(mainnetFork);
    uint256 proposalId = deployl1Proposal.createProposal(
      address(bridgeExecutor),
      address(miMaticPayload)
    );

    // 2. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('StateSynced(uint256,address,bytes)'),
      entries[2].topics[0]
    );
    assertEq(address(uint160(uint256(entries[2].topics[2]))), FX_CHILD_ADDRESS);

    vm.selectFork(polygonFork);
    vm.stopPrank();
    vm.startPrank(BRIDGE_ADMIN);

    // 3. mock the receive on l2 with the data emitted on StateSynced
    IStateReceiver(FX_CHILD_ADDRESS).onStateReceive(
      uint256(entries[2].topics[1]),
      this._cutBytes(entries[2].data)
    );

    // 4. execute proposal on l2
    vm.warp(
      block.timestamp + IBridgeExecutor(POLYGON_BRIDGE_EXECUTOR).getDelay() + 1
    );
    // execute the proposal
    IBridgeExecutor(POLYGON_BRIDGE_EXECUTOR).execute(
      IBridgeExecutor(POLYGON_BRIDGE_EXECUTOR).getActionsSetCount() - 1
    );
    vm.stopPrank();

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = AaveV3Helpers._getReservesConfigs(
      false
    );

    ReserveConfig memory expectedAssetConfig = ReserveConfig({
      symbol: 'miMATIC',
      underlying: MIMATIC,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 0,
      liquidationThreshold: 0,
      liquidationBonus: 0,
      liquidationProtocolFee: 1000,
      reserveFactor: 1000,
      usageAsCollateralEnabled: false,
      borrowingEnabled: true,
      interestRateStrategy: AaveV3Helpers
        ._findReserveConfig(allConfigsAfter, 'USDT', false)
        .interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      supplyCap: 10_000_000,
      borrowCap: 0,
      debtCeiling: 0,
      eModeCategory: 1
    });

    AaveV3Helpers._validateReserveConfig(expectedAssetConfig, allConfigsAfter);

    AaveV3Helpers._noReservesConfigsChangesApartNewListings(
      allConfigsBefore,
      allConfigsAfter
    );

    AaveV3Helpers._validateReserveTokensImpls(
      vm,
      AaveV3Helpers._findReserveConfig(allConfigsAfter, 'miMATIC', false),
      ReserveTokens({
        aToken: miMaticPayload.ATOKEN_IMPL(),
        stableDebtToken: miMaticPayload.SDTOKEN_IMPL(),
        variableDebtToken: miMaticPayload.VDTOKEN_IMPL()
      })
    );

    AaveV3Helpers._validateAssetSourceOnOracle(
      MIMATIC,
      miMaticPayload.PRICE_FEED()
    );

    // impl should be same as USDC
    AaveV3Helpers._validateReserveTokensImpls(
      vm,
      AaveV3Helpers._findReserveConfig(allConfigsAfter, 'USDC', false),
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
    address aMIMATIC = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'miMATIC', false)
      .aToken;
    address vMIMATIC = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'miMATIC', false)
      .variableDebtToken;
    address sMIMATIC = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'miMATIC', false)
      .stableDebtToken;
    address aDAI = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'DAI', false)
      .aToken;

    AaveV3Helpers._deposit(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      MIMATIC,
      666 ether,
      true,
      aMIMATIC
    );

    // We check revert when trying to borrow (not enabled as collateral, so any mode works)
    try
      AaveV3Helpers._borrow(
        vm,
        MIMATIC_WHALE,
        MIMATIC_WHALE,
        MIMATIC,
        10 ether,
        1,
        sMIMATIC
      )
    {
      revert('_testProposal() : BORROW_NOT_REVERTING');
    } catch Error(string memory revertReason) {
      require(
        keccak256(bytes(revertReason)) == keccak256(bytes('34')),
        '_testProposal() : INVALID_VARIABLE_REVERT_MSG'
      );
      vm.stopPrank();
    }

    vm.startPrank(DAI_WHALE);
    IERC20(DAI).transfer(MIMATIC_WHALE, 666 ether);
    vm.stopPrank();

    AaveV3Helpers._deposit(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      DAI,
      666 ether,
      true,
      aDAI
    );

    AaveV3Helpers._borrow(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      MIMATIC,
      222 ether,
      2,
      vMIMATIC
    );

    // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
    skip(1);

    AaveV3Helpers._repay(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      MIMATIC,
      IERC20(MIMATIC).balanceOf(MIMATIC_WHALE),
      2,
      vMIMATIC,
      true
    );

    AaveV3Helpers._withdraw(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      MIMATIC,
      type(uint256).max,
      aMIMATIC
    );
  }
}
