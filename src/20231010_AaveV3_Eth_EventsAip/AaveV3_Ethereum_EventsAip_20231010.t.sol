// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3_Ethereum_EventsAip_20231010} from './AaveV3_Ethereum_EventsAip_20231010.sol';
import 'forge-std/console.sol';

/**
 * @dev Test for AaveV3_Ethereum_EventsAip_20231010
 * command: make test-contract filter=AaveV3_Ethereum_EventsAip_20231010
 */

contract AaveV3_Ethereum_EventsAip_20231010_Test is ProtocolV2TestBase {
  AaveV3_Ethereum_EventsAip_20231010 internal proposal;

  address RECEIVER = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  address COLLECTOR = 0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c;

  uint256 public constant GHO_AMOUNT = 550_000e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18390065);
    proposal = new AaveV3_Ethereum_EventsAip_20231010();
  }

  function testProposalExecution() public {
    AaveV3_Ethereum_EventsAip_20231010 payload = new AaveV3_Ethereum_EventsAip_20231010();
    uint256 ghoBalanceBeforeFunding = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      COLLECTOR
    );

    // Simulates having appropriate funds in proxy
    // https://app.aave.com/governance/proposal/?proposalId=347
    // 0x121fE3fC3f617ACE9730203d2E27177131C4315e
    // https://github.com/bgd-labs/aave-proposals/blob/545b17d8817e8aa86d99db94bfd1e4a2ae575f3d/src/20230926_AaveV3_Eth_GHOFunding/AaveV3_Ethereum_GHOFunding_20230926.t.sol#L39
    uint256 daiBalanceProxyBefore = IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(
      0x0eB322ac55dB67a5cA0810BA0eDae3501b1B7263
    );
    uint256 simulatedSwapBalance = 370_000e18 +
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(COLLECTOR);

    GovHelpers.passVoteAndExecute(vm, 347);

    uint256 daiBalanceProxyAfter = IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(
      0x0eB322ac55dB67a5cA0810BA0eDae3501b1B7263
    );

    // 0.001e18 is 0.1%
    assertApproxEqRel(daiBalanceProxyBefore + simulatedSwapBalance, daiBalanceProxyAfter, 0.001e18);

    // assume DAI swapped for GHO
    deal(
      address(AaveV3EthereumAssets.GHO_UNDERLYING),
      COLLECTOR,
      GHO_AMOUNT + ghoBalanceBeforeFunding
    );
    uint256 ghoBalanceAfterFunding = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      COLLECTOR
    );

    assertEq(ghoBalanceAfterFunding, ghoBalanceBeforeFunding + GHO_AMOUNT);

    uint256 receiverBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(RECEIVER);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 receiverBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(RECEIVER);

    assertEq(receiverBalanceAfter, receiverBalanceBefore + GHO_AMOUNT);
  }
}
