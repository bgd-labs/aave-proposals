// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_BugBounty_20230710} from './AaveV3_Eth_BugBounty_20230710.sol';

/**
 * @dev Test for AaveV3_Eth_BugBounty_20230710
 * command: make test-contract filter=AaveV3_Eth_BugBounty_20230710
 */
contract AaveV3_Eth_BugBounty_20230710_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17664219);
  }

  function testProposalExecution() public {
    AaveV3_Eth_BugBounty_20230710 proposal = new AaveV3_Eth_BugBounty_20230710();
    IERC20 aUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN);

    uint256 totalAmountToDisburse = proposal.KANKODU_AMOUNT() +
      proposal.EMANUELE_AMOUNT() +
      proposal.CMICHEL_AMOUNT() +
      proposal.WATCHPUG_AMOUNT();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Eth_BugBounty_20230710',
      AaveV3Ethereum.POOL
    );

    uint256 amountCollectorBefore = aUSDT.balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 amountKankoduBefore = aUSDT.balanceOf(proposal.KANKODU());
    uint256 amountEmanueleBefore = aUSDT.balanceOf(proposal.EMANUELE());
    uint256 amountCmichelBefore = aUSDT.balanceOf(proposal.CMICHEL());
    uint256 amountWatchpugBefore = aUSDT.balanceOf(proposal.WATCHPUG());

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 amountCollectorAfter = aUSDT.balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 amountKankoduAfter = aUSDT.balanceOf(proposal.KANKODU());
    uint256 amountEmanueleAfter = aUSDT.balanceOf(proposal.EMANUELE());
    uint256 amountCmichelAfter = aUSDT.balanceOf(proposal.CMICHEL());
    uint256 amountWatchpugAfter = aUSDT.balanceOf(proposal.WATCHPUG());

    assertApproxEqAbs(amountCollectorBefore, amountCollectorAfter + totalAmountToDisburse, 1);
    assertApproxEqAbs(amountKankoduBefore, amountKankoduAfter - proposal.KANKODU_AMOUNT(), 1);
    assertApproxEqAbs(amountEmanueleBefore, amountEmanueleAfter - proposal.EMANUELE_AMOUNT(), 1);
    assertApproxEqAbs(amountCmichelBefore, amountCmichelAfter - proposal.CMICHEL_AMOUNT(), 1);
    assertApproxEqAbs(amountWatchpugBefore, amountWatchpugAfter - proposal.WATCHPUG_AMOUNT(), 1);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Eth_BugBounty_20230710',
      AaveV3Ethereum.POOL
    );

    _noReservesConfigsChangesApartNewListings(allConfigsBefore, allConfigsAfter);
  }
}
