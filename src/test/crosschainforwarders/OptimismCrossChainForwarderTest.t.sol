// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import 'forge-std/Test.sol';
// import {AaveV3Optimism, AaveMisc} from 'aave-address-book/AaveAddressBook.sol';
// import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
// import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
// import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
// import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
// import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
// import {IL2CrossDomainMessenger} from 'governance-crosschain-bridges/contracts/dependencies/optimism/interfaces/IL2CrossDomainMessenger.sol';
// import {CrosschainForwarderOptimism} from '../../lib/crosschainforwarders/CrosschainForwarderOptimism.sol';
// import {OpPayload} from '../../contracts/optimism/OpPayload.sol';

// /**
//  * This test covers syncing between mainnet and optimism.
//  */
// contract OptimismCrossChainForwarderTest is ProtocolV3TestBase {
//   // the identifiers of the forks
//   uint256 mainnetFork;
//   uint256 optimismFork;

//   OpPayload public opPayload;

//   bytes32 ipfs = 0x7ecafb3b0b7e418336cccb0c82b3e25944011bf11e41f8dc541841da073fe4f1;

//   address public constant OPTIMISM_BRIDGE_EXECUTOR = AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR;
//   IL2CrossDomainMessenger public OVM_L2_CROSS_DOMAIN_MESSENGER =
//     IL2CrossDomainMessenger(0x4200000000000000000000000000000000000007);

//   address public constant OP = 0x4200000000000000000000000000000000000042;

//   address public constant DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;

//   function setUp() public {
//     optimismFork = vm.createSelectFork(vm.rpcUrl('optimism'), 30264427);
//     opPayload = new OpPayload();
//     mainnetFork = vm.createFork(vm.rpcUrl('mainnet'), 15783218);
//   }

//   function testProposalE2E() public {
//     vm.selectFork(optimismFork);
//     // we get all configs to later on check that payload only changes OP
//     ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Optimism.POOL);
//     // 1. create l1 proposal
//     vm.selectFork(mainnetFork);
//     vm.startPrank(AaveMisc.ECOSYSTEM_RESERVE);
//     GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
//     payloads[0] = GovHelpers.buildOptimism(address(opPayload));

//     uint256 proposalId = GovHelpers.createProposal(payloads, ipfs);
//     vm.stopPrank();
//     // 2. execute proposal and record logs so we can extract the emitted StateSynced event
//     vm.recordLogs();
//     GovHelpers.passVoteAndExecute(vm, proposalId);
//     Vm.Log[] memory entries = vm.getRecordedLogs();
//     assertEq(keccak256('SentMessage(address,address,bytes,uint256,uint256)'), entries[3].topics[0]);
//     assertEq(address(uint160(uint256(entries[3].topics[1]))), OPTIMISM_BRIDGE_EXECUTOR);
//     (address sender, bytes memory message, uint256 nonce) = abi.decode(
//       entries[3].data,
//       (address, bytes, uint256)
//     );
//     // 3. mock the receive on l2 with the data emitted on StateSynced
//     vm.selectFork(optimismFork);
//     vm.startPrank(0x36BDE71C97B33Cc4729cf772aE268934f7AB70B2); // AddressAliasHelper.applyL1ToL2Alias on L1_CROSS_DOMAIN_MESSENGER_ADDRESS
//     OVM_L2_CROSS_DOMAIN_MESSENGER.relayMessage(OPTIMISM_BRIDGE_EXECUTOR, sender, message, nonce);
//     vm.stopPrank();

//     // 4. execute proposal on l2
//     BridgeExecutorHelpers.waitAndExecuteLatest(vm, OPTIMISM_BRIDGE_EXECUTOR);

//     // 5. verify results
//     ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Optimism.POOL);
//     ReserveConfig memory expectedAssetConfig = ReserveConfig({
//       symbol: 'OP',
//       underlying: OP,
//       aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
//       variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
//       stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
//       decimals: 18,
//       ltv: 3000,
//       liquidationThreshold: 4000,
//       liquidationBonus: 11000,
//       liquidationProtocolFee: 1000,
//       reserveFactor: 2000,
//       usageAsCollateralEnabled: true,
//       borrowingEnabled: false,
//       interestRateStrategy: _findReserveConfigBySymbol(allConfigsAfter, 'WETH')
//         .interestRateStrategy,
//       stableBorrowRateEnabled: false,
//       isActive: true,
//       isFrozen: false,
//       isSiloed: false,
//       isBorrowableInIsolation: false,
//       isFlashloanable: false,
//       supplyCap: 20_000_000,
//       borrowCap: 0,
//       debtCeiling: 2_000_000_00,
//       eModeCategory: 0
//     });

//     _validateReserveConfig(expectedAssetConfig, allConfigsAfter);

//     _noReservesConfigsChangesApartNewListings(allConfigsBefore, allConfigsAfter);

//     _validateReserveTokensImpls(
//       AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
//       _findReserveConfigBySymbol(allConfigsAfter, 'OP'),
//       ReserveTokens({
//         aToken: opPayload.ATOKEN_IMPL(),
//         stableDebtToken: opPayload.SDTOKEN_IMPL(),
//         variableDebtToken: opPayload.VDTOKEN_IMPL()
//       })
//     );

//     _validateAssetSourceOnOracle(
//       AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
//       OP,
//       opPayload.PRICE_FEED()
//     );

//     // impl should be same as USDC
//     _validateReserveTokensImpls(
//       AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
//       _findReserveConfigBySymbol(allConfigsAfter, 'USDC'),
//       ReserveTokens({
//         aToken: opPayload.ATOKEN_IMPL(),
//         stableDebtToken: opPayload.SDTOKEN_IMPL(),
//         variableDebtToken: opPayload.VDTOKEN_IMPL()
//       })
//     );
//     _validatePoolActionsPostListing(allConfigsAfter);
//   }

//   function _validatePoolActionsPostListing(ReserveConfig[] memory allReservesConfigs) internal {
//     ReserveConfig memory op = _findReserveConfigBySymbol(allReservesConfigs, 'OP');
//     ReserveConfig memory dai = _findReserveConfigBySymbol(allReservesConfigs, 'DAI');

//     address user0 = address(1);
//     _deposit(op, AaveV3Optimism.POOL, user0, 1000 ether);

//     this._borrow(dai, AaveV3Optimism.POOL, user0, 100 ether, false);

//     // Not possible to borrow and repay when vdebt index doesn't changing, so moving 1s
//     skip(1);

//     _repay(dai, AaveV3Optimism.POOL, user0, 1000 ether, false);

//     _withdraw(op, AaveV3Optimism.POOL, user0, type(uint256).max);
//   }
// }
