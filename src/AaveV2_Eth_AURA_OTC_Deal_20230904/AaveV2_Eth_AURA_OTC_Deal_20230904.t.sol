// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_AURA_OTC_Deal_20230508} from 'src/AaveV2_Eth_AURA_OTC_Deal_20230904/AaveV2_Eth_AURA_OTC_Deal_20230904.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV2_Eth_AURA_OTC_Deal_20230508
 * command: make test-contract filter=AaveV2_Eth_AURA_OTC_Deal_20230508
 */
contract AaveV2_Eth_AURA_OTC_Deal_20230508_Test is ProtocolV2TestBase {
  address public constant OLYMPUS_ADDRESS = 0x245cc372C84B3645Bf0Ffe6538620B04a217988B;
  address public constant AURA_TOKEN = 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF;
  uint256 public constant AURA_AMOUNT = 443_674e18;
  uint256 public constant DAI_AMOUNT = 420_159e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18086015);
  }

  function testProposalExecution() public {
    AaveV2_Eth_AURA_OTC_Deal_20230508 proposal = new AaveV2_Eth_AURA_OTC_Deal_20230508();

    uint256 aDAIBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 AURABalanceBefore = IERC20(AURA_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    vm.startPrank(OLYMPUS_ADDRESS);
    IERC20(AURA_TOKEN).approve(AaveGovernanceV2.SHORT_EXECUTOR, AURA_AMOUNT);
    vm.stopPrank();

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 aDAIBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 AURABalanceAfter = IERC20(AURA_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    // Check if the SHORT_EXECUTOR's DAI balance is 0 after execution

    uint256 shortExecutorDAIBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      AaveGovernanceV2.SHORT_EXECUTOR
    );
    assertEq(shortExecutorDAIBalance, 0);

    assertApproxEqAbs(aDAIBalanceAfter, aDAIBalanceBefore - DAI_AMOUNT, 1500 wei, 'aDAI_LEFTOVER');

    assertEq(AURABalanceAfter, AURABalanceBefore + AURA_AMOUNT);

    e2eTest(AaveV2Ethereum.POOL);
  }
}
