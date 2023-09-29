// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830} from './AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830.sol';

/**
 * @dev Test for AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830
 * command: make test-contract filter=AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830
 */
 contract AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18023212);
  }

  function testProposalExecution() public {
    AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830 proposal = new AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830();
    IERC20 aUSDT = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN);

    uint256 totalAmountToDisburse = 162000 * 1e6;
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830',
      AaveV3Ethereum.POOL
    );

    uint256 amountCollectorBefore = aUSDT.balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 amountSigPBefore = aUSDT.balanceOf(proposal.SIGP());

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 amountCollectorAfter = aUSDT.balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 amountSigPAfter = aUSDT.balanceOf(proposal.SIGP());

    assertApproxEqAbs(amountCollectorBefore, amountCollectorAfter + totalAmountToDisburse, 1);
    assertApproxEqAbs(amountSigPBefore, amountSigPAfter - proposal.FEE(), 1);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830',
      'postAaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830'
    );

    _noReservesConfigsChangesApartNewListings(allConfigsBefore, allConfigsAfter);
  }
}
