// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Helpers, ReserveConfig, ReserveTokens, IERC20} from '../helpers/AaveV3Helpers.sol';
import {IL2CrossDomainMessenger, AddressAliasHelper} from '../../interfaces/optimism/ICrossDomainMessenger.sol';
import {IBridgeExecutor} from '../../interfaces/IBridgeExecutor.sol';
import {CrosschainForwarderOptimism} from '../../contracts/optimism/CrosschainForwarderOptimism.sol';
import {OpPayload} from '../../contracts/optimism/OpPayload.sol';
import {DeployL1OptimismProposal} from '../../../script/DeployL1OptimismProposal.s.sol';

contract OptimismOpE2ETest is Test {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 optimismFork;

  OpPayload public opPayload;

  address public constant BRIDGE_ADMIN =
    0x000000000000000000000000000000000000dEaD;
  address public constant FX_CHILD_ADDRESS =
    0x8397259c983751DAf40400790063935a11afa28a;
  address public constant OPTIMISM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;
  IL2CrossDomainMessenger public OVM_L2_CROSS_DOMAIN_MESSENGER =
    IL2CrossDomainMessenger(0x4200000000000000000000000000000000000007);

  address public constant FRAX = 0x45c32fA6DF82ead1e2EF74d17b76547EDdFaFF89;
  address public constant FRAX_WHALE =
    0x6e1A844AFff1aa2a8ba3127dB83088e196187110;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
  address public constant DAI_WHALE =
    0xd7052EC0Fe1fe25b20B7D65F6f3d490fCE58804f;
  address public constant AAVE_WHALE =
    address(0x25F2226B597E8F9514B3F68F00f494cF4f286491);

  function setUp() public {
    optimismFork = vm.createFork(vm.rpcUrl('optimism'), 15526675);
    mainnetFork = vm.createFork(vm.rpcUrl('ethereum'), 15526675);
  }

  function testProposalE2E() public {
    //vm.makePersistent(OPTIMISM_BRIDGE_EXECUTOR);
    vm.selectFork(mainnetFork);
    address crosschainForwarderOptimism = address(
      new CrosschainForwarderOptimism()
    );

    vm.selectFork(optimismFork);
    // we get all configs to later on check that payload only changes FRAX
    ReserveConfig[] memory allConfigsBefore = AaveV3Helpers._getReservesConfigs(
      false
    );
    // 1. deploy l2 payload
    vm.selectFork(optimismFork);
    opPayload = new OpPayload();
    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(AAVE_WHALE);
    uint256 proposalId = DeployL1OptimismProposal._deployL1Proposal(
      address(opPayload),
      0xec9d2289ab7db9bfbf2b0f2dd41ccdc0a4003e9e0d09e40dee09095145c63fb5,
      address(crosschainForwarderOptimism)
    );
    vm.stopPrank();
    // 3. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);
    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('SentMessage(address,address,bytes,uint256,uint256)'),
      entries[3].topics[0]
    );
    assertEq(
      address(uint160(uint256(entries[3].topics[1]))),
      OPTIMISM_BRIDGE_EXECUTOR
    );
    (address sender, bytes memory message, uint256 nonce) = abi.decode(
      entries[3].data,
      (address, bytes, uint256)
    );
    // 4. mock the receive on l2 with the data emitted on StateSynced
    vm.selectFork(optimismFork);
    vm.startPrank(0x36BDE71C97B33Cc4729cf772aE268934f7AB70B2); // AddressAliasHelper.applyL1ToL2Alias on L1_CROSS_DOMAIN_MESSANGER_ADDRESS
    OVM_L2_CROSS_DOMAIN_MESSENGER.relayMessage(
      OPTIMISM_BRIDGE_EXECUTOR,
      sender,
      message,
      nonce
    );
    vm.stopPrank();
    // 5. execute proposal on l2
    vm.warp(
      block.timestamp + IBridgeExecutor(OPTIMISM_BRIDGE_EXECUTOR).getDelay() + 1
    );
    // execute the proposal
    IBridgeExecutor(OPTIMISM_BRIDGE_EXECUTOR).execute(
      IBridgeExecutor(OPTIMISM_BRIDGE_EXECUTOR).getActionsSetCount() - 1
    );
    // // 6. verify results
    // ReserveConfig[] memory allConfigsAfter = AaveV3Helpers._getReservesConfigs(
    //   false
    // );
    // ReserveConfig memory expectedAssetConfig = ReserveConfig({
    //   symbol: 'FRAX',
    //   underlying: FRAX,
    //   aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
    //   variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
    //   stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
    //   decimals: 18,
    //   ltv: 7500,
    //   liquidationThreshold: 8000,
    //   liquidationBonus: 10500,
    //   liquidationProtocolFee: 1000,
    //   reserveFactor: 1000,
    //   usageAsCollateralEnabled: true,
    //   borrowingEnabled: true,
    //   interestRateStrategy: AaveV3Helpers
    //     ._findReserveConfig(allConfigsAfter, 'USDT', false)
    //     .interestRateStrategy,
    //   stableBorrowRateEnabled: false,
    //   isActive: true,
    //   isFrozen: false,
    //   isSiloed: false,
    //   supplyCap: 50_000_000,
    //   borrowCap: 0,
    //   debtCeiling: 2_000_000_00,
    //   eModeCategory: 1
    // });
    // AaveV3Helpers._validateReserveConfig(expectedAssetConfig, allConfigsAfter);
    // AaveV3Helpers._noReservesConfigsChangesApartNewListings(
    //   allConfigsBefore,
    //   allConfigsAfter
    // );
    // AaveV3Helpers._validateReserveTokensImpls(
    //   vm,
    //   AaveV3Helpers._findReserveConfig(allConfigsAfter, 'FRAX', false),
    //   ReserveTokens({
    //     aToken: fraxPayload.ATOKEN_IMPL(),
    //     stableDebtToken: fraxPayload.SDTOKEN_IMPL(),
    //     variableDebtToken: fraxPayload.VDTOKEN_IMPL()
    //   })
    // );
    // AaveV3Helpers._validateAssetSourceOnOracle(FRAX, fraxPayload.PRICE_FEED());
    // // impl should be same as USDC
    // AaveV3Helpers._validateReserveTokensImpls(
    //   vm,
    //   AaveV3Helpers._findReserveConfig(allConfigsAfter, 'USDC', false),
    //   ReserveTokens({
    //     aToken: fraxPayload.ATOKEN_IMPL(),
    //     stableDebtToken: fraxPayload.SDTOKEN_IMPL(),
    //     variableDebtToken: fraxPayload.VDTOKEN_IMPL()
    //   })
    // );
    // _validatePoolActionsPostListing(allConfigsAfter);
  }

  function _validatePoolActionsPostListing(
    ReserveConfig[] memory allReservesConfigs
  ) internal {
    address aFRAX = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'FRAX', false)
      .aToken;
    address vFRAX = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'FRAX', false)
      .variableDebtToken;
    address sFRAX = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'FRAX', false)
      .stableDebtToken;
    address vDAI = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'DAI', false)
      .variableDebtToken;

    AaveV3Helpers._deposit(
      vm,
      FRAX_WHALE,
      FRAX_WHALE,
      FRAX,
      666 ether,
      true,
      aFRAX
    );

    AaveV3Helpers._borrow(vm, FRAX_WHALE, FRAX_WHALE, DAI, 2 ether, 2, vDAI);

    // We check revert when trying to borrow (not enabled in isolation)
    try
      AaveV3Helpers._borrow(
        vm,
        FRAX_WHALE,
        FRAX_WHALE,
        FRAX,
        300 ether,
        2,
        vFRAX
      )
    {
      revert('_testProposal() : BORROW_NOT_REVERTING');
    } catch Error(string memory revertReason) {
      require(
        keccak256(bytes(revertReason)) == keccak256(bytes('60')),
        '_testProposal() : INVALID_VARIABLE_REVERT_MSG'
      );
      vm.stopPrank();
    }

    // We check revert when trying to borrow (not enabled in isolation)
    try
      AaveV3Helpers._borrow(
        vm,
        FRAX_WHALE,
        FRAX_WHALE,
        FRAX,
        10 ether,
        1,
        sFRAX
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
    IERC20(DAI).transfer(FRAX_WHALE, 1000 ether);
    vm.stopPrank();

    AaveV3Helpers._borrow(vm, FRAX_WHALE, FRAX_WHALE, DAI, 222 ether, 2, vDAI);

    // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
    skip(1);

    AaveV3Helpers._repay(
      vm,
      FRAX_WHALE,
      FRAX_WHALE,
      DAI,
      IERC20(DAI).balanceOf(FRAX_WHALE),
      2,
      vDAI,
      true
    );

    AaveV3Helpers._withdraw(
      vm,
      FRAX_WHALE,
      FRAX_WHALE,
      FRAX,
      type(uint256).max,
      aFRAX
    );
  }
}
