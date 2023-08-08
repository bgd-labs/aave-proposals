// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_CRV_OTC_Deal_20230508} from './AaveV2_Eth_CRV_OTC_Deal_20230508.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV2_Eth_CRV_OTC_Deal_20230508
 * command: make test-contract filter=AaveV2_Eth_CRV_OTC_Deal_20230508
 */
contract AaveV2_Eth_CRV_OTC_Deal_20230508_Test is ProtocolV2TestBase {
  uint256 public constant USDT_AMOUNT = 2_000_000e6;
  uint256 public constant ACRV_AMOUNT = 5_000_000e18;
  address public constant MICH_ADDRESS = 0x7a16fF8270133F063aAb6C9977183D9e72835428;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17851065);
  }

  function testProposalExecution() public {
    AaveV2_Eth_CRV_OTC_Deal_20230508 proposal = new AaveV2_Eth_CRV_OTC_Deal_20230508();

    uint256 aUSDTBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 aCRVBalanceBefore = IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 MichDebtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_V_TOKEN).balanceOf(
      MICH_ADDRESS
    );

    vm.startPrank(MICH_ADDRESS);
    IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).approve(AaveGovernanceV2.SHORT_EXECUTOR, ACRV_AMOUNT);
    vm.stopPrank();

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 aUSDTBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 aCRVBalanceAfter = IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 MichDebtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_V_TOKEN).balanceOf(
      MICH_ADDRESS
    );

    assertApproxEqAbs(
      aUSDTBalanceAfter,
      aUSDTBalanceBefore - USDT_AMOUNT,
      1500 ether,
      'aUSDT_LEFTOVER'
    );
    assertEq(aCRVBalanceAfter, aCRVBalanceBefore + ACRV_AMOUNT);

    assertApproxEqAbs(
      MichDebtBalanceAfter,
      MichDebtBalanceBefore - USDT_AMOUNT,
      1500 ether,
      'Debt_LEFTOVER'
    );

    e2eTest(AaveV2Ethereum.POOL);
  }
}
