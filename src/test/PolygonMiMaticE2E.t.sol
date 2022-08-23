// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

import {CrosschainForwarderPolygon} from '../contracts/polygon/CrosschainForwarderPolygon.sol';
import {MiMaticPayload} from '../contracts/polygon/MiMaticPayload.sol';
import {IStateReceiver} from '../interfaces/IFx.sol';
import {IBridgeExecutor} from '../interfaces/IBridgeExecutor.sol';
import {AaveV3Helpers, ReserveConfig, ReserveTokens, IERC20} from './helpers/AaveV3Helpers.sol';
import {DeployL1PolygonProposal} from '../../script/DeployL1PolygonProposal.s.sol';

contract PolygonMiMaticE2ETest is Test {
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
  address public constant MIMATIC_WHALE =
    0x95dD59343a893637BE1c3228060EE6afBf6F0730;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
  address public constant DAI_WHALE =
    0xd7052EC0Fe1fe25b20B7D65F6f3d490fCE58804f;

  address public constant AAVE_WHALE =
    address(0x25F2226B597E8F9514B3F68F00f494cF4f286491);

  function setUp() public {
    polygonFork = vm.createFork(vm.rpcUrl('polygon'), 31237525);
    mainnetFork = vm.createSelectFork(vm.rpcUrl('mainnet'), 15389777);
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
    ReserveConfig[] memory allConfigsBefore = AaveV3Helpers._getReservesConfigs(
      false
    );

    // 1. deploy l2 payload
    vm.selectFork(polygonFork);
    miMaticPayload = new MiMaticPayload();

    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(AAVE_WHALE);
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

    // 5. execute proposal on l2
    vm.warp(
      block.timestamp + IBridgeExecutor(POLYGON_BRIDGE_EXECUTOR).getDelay() + 1
    );
    // execute the proposal
    IBridgeExecutor(POLYGON_BRIDGE_EXECUTOR).execute(
      IBridgeExecutor(POLYGON_BRIDGE_EXECUTOR).getActionsSetCount() - 1
    );

    // 6. verify results
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
      ltv: 7500,
      liquidationThreshold: 8000,
      liquidationBonus: 10500,
      liquidationProtocolFee: 1000,
      reserveFactor: 1000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: AaveV3Helpers
        ._findReserveConfig(allConfigsAfter, 'USDT', false)
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
    address sMIMATIC = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'miMATIC', false)
      .stableDebtToken;
    address vDAI = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'DAI', false)
      .variableDebtToken;

    AaveV3Helpers._deposit(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      MIMATIC,
      666 ether,
      true,
      aMIMATIC
    );

    // We check revert when trying to borrow (not enabled in isolation)
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
        keccak256(bytes(revertReason)) == keccak256(bytes('60')),
        '_testProposal() : INVALID_STABLE_REVERT_MSG'
      );
      vm.stopPrank();
    }

    vm.startPrank(DAI_WHALE);
    IERC20(DAI).transfer(MIMATIC_WHALE, 666 ether);
    vm.stopPrank();

    AaveV3Helpers._borrow(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      DAI,
      222 ether,
      2,
      vDAI
    );

    // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
    skip(1);

    AaveV3Helpers._repay(
      vm,
      MIMATIC_WHALE,
      MIMATIC_WHALE,
      DAI,
      IERC20(DAI).balanceOf(MIMATIC_WHALE),
      2,
      vDAI,
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
