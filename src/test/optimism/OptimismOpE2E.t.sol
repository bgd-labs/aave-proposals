// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Helpers, ReserveConfig, ReserveTokens, IERC20} from '../helpers/AaveV3Helpers.sol';
import {IL2CrossDomainMessenger, AddressAliasHelper} from '../../interfaces/optimism/ICrossDomainMessenger.sol';
import {IExecutorBase} from '../../interfaces/optimism/IExecutorBase.sol';
import {CrosschainForwarderOptimism} from '../../contracts/optimism/CrosschainForwarderOptimism.sol';
import {OpPayload} from '../../contracts/optimism/OpPayload.sol';
import {DeployL1OptimismProposal} from '../../../script/DeployL1OptimismProposal.s.sol';

contract OptimismOpE2ETest is ProtocolV3TestBase {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 optimismFork;

  OpPayload public opPayload;

  address public constant OPTIMISM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;
  IL2CrossDomainMessenger public OVM_L2_CROSS_DOMAIN_MESSENGER =
    IL2CrossDomainMessenger(0x4200000000000000000000000000000000000007);

  address public constant OP = 0x4200000000000000000000000000000000000042;
  address public constant OP_WHALE = 0x2A82Ae142b2e62Cb7D10b55E323ACB1Cab663a26;

  address public constant DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;
  address public constant DAI_WHALE =
    0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE;
  address public constant AAVE_WHALE =
    address(0x25F2226B597E8F9514B3F68F00f494cF4f286491);

  function setUp() public {
    optimismFork = vm.createFork(vm.rpcUrl('optimism'), 22961333);
    mainnetFork = vm.createFork(vm.rpcUrl('ethereum'), 15526675);
    vm.selectFork(optimismFork);
    vm.startPrank(AaveV3Optimism.ACL_ADMIN);
    // -------------
    // Claim pool admin
    // Only needed for the first proposal on any pool. If ACL_ADMIN was previously set it will ignore
    // https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/AccessControl.sol#L207
    // -------------
    AaveV3Optimism.ACL_MANAGER.addPoolAdmin(OPTIMISM_BRIDGE_EXECUTOR);
    AaveV3Optimism.ACL_MANAGER.addRiskAdmin(OPTIMISM_BRIDGE_EXECUTOR);
    vm.stopPrank();
  }

  function testProposalE2E() public {
    vm.selectFork(mainnetFork);
    address crosschainForwarderOptimism = address(
      new CrosschainForwarderOptimism()
    );

    vm.selectFork(optimismFork);
    // we get all configs to later on check that payload only changes OP
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
    vm.startPrank(0x36BDE71C97B33Cc4729cf772aE268934f7AB70B2); // AddressAliasHelper.applyL1ToL2Alias on L1_CROSS_DOMAIN_MESSENGER_ADDRESS
    OVM_L2_CROSS_DOMAIN_MESSENGER.relayMessage(
      OPTIMISM_BRIDGE_EXECUTOR,
      sender,
      message,
      nonce
    );
    vm.stopPrank();
    // 5. execute proposal on l2
    vm.warp(
      block.timestamp + IExecutorBase(OPTIMISM_BRIDGE_EXECUTOR).getDelay() + 1
    );
    // execute the proposal
    IExecutorBase(OPTIMISM_BRIDGE_EXECUTOR).execute(
      IExecutorBase(OPTIMISM_BRIDGE_EXECUTOR).getActionsSetCount() - 1
    );
    // 6. verify results
    ReserveConfig[] memory allConfigsAfter = AaveV3Helpers._getReservesConfigs(
      false
    );
    ReserveConfig memory expectedAssetConfig = ReserveConfig({
      symbol: 'OP',
      underlying: OP,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 3000,
      liquidationThreshold: 5000,
      liquidationBonus: 11200,
      liquidationProtocolFee: 1000,
      reserveFactor: 3000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: AaveV3Helpers
        ._findReserveConfig(allConfigsAfter, 'WETH', false)
        .interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      supplyCap: 1_000_000,
      borrowCap: 0,
      debtCeiling: 0,
      eModeCategory: 0
    });
    AaveV3Helpers._validateReserveConfig(expectedAssetConfig, allConfigsAfter);
    AaveV3Helpers._noReservesConfigsChangesApartNewListings(
      allConfigsBefore,
      allConfigsAfter
    );
    AaveV3Helpers._validateReserveTokensImpls(
      vm,
      AaveV3Helpers._findReserveConfig(allConfigsAfter, 'OP', false),
      ReserveTokens({
        aToken: opPayload.ATOKEN_IMPL(),
        stableDebtToken: opPayload.SDTOKEN_IMPL(),
        variableDebtToken: opPayload.VDTOKEN_IMPL()
      })
    );
    AaveV3Helpers._validateAssetSourceOnOracle(OP, opPayload.PRICE_FEED());
    // impl should be same as USDC
    AaveV3Helpers._validateReserveTokensImpls(
      vm,
      AaveV3Helpers._findReserveConfig(allConfigsAfter, 'USDC', false),
      ReserveTokens({
        aToken: opPayload.ATOKEN_IMPL(),
        stableDebtToken: opPayload.SDTOKEN_IMPL(),
        variableDebtToken: opPayload.VDTOKEN_IMPL()
      })
    );
    _validatePoolActionsPostListing(allConfigsAfter);
  }

  function _validatePoolActionsPostListing(
    ReserveConfig[] memory allReservesConfigs
  ) internal {
    address aOP = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'OP', false)
      .aToken;
    address vOP = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'OP', false)
      .variableDebtToken;
    address sOP = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'OP', false)
      .stableDebtToken;
    address vDAI = AaveV3Helpers
      ._findReserveConfig(allReservesConfigs, 'DAI', false)
      .variableDebtToken;

    AaveV3Helpers._deposit(vm, OP_WHALE, OP_WHALE, OP, 1000 ether, true, aOP);

    vm.startPrank(DAI_WHALE);
    IERC20(DAI).transfer(OP_WHALE, 1000 ether);
    vm.stopPrank();

    AaveV3Helpers._borrow(vm, OP_WHALE, OP_WHALE, DAI, 222 ether, 2, vDAI);

    // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
    skip(1);

    AaveV3Helpers._repay(
      vm,
      OP_WHALE,
      OP_WHALE,
      DAI,
      IERC20(DAI).balanceOf(OP_WHALE),
      2,
      vDAI,
      true
    );

    AaveV3Helpers._withdraw(vm, OP_WHALE, OP_WHALE, OP, type(uint256).max, aOP);
  }
}
