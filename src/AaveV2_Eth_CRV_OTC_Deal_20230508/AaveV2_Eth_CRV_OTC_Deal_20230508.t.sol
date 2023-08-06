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
  address public constant MICH_ADDRESS = 0x329c54289Ff5D6B7b7daE13592C6B1EDA1543eD4;
  address public constant SHORT_EXECUTOR = 0xEE56e2B3D491590B5b31738cC34d5232F378a8D5;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17851065);
  }

  function testProposalExecution() public {
    AaveV2_Eth_CRV_OTC_Deal_20230508 proposal = new AaveV2_Eth_CRV_OTC_Deal_20230508();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Eth_CRV_OTC_Deal_20230508',
      AaveV2Ethereum.POOL
    );

    uint256 aUSDTBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 aCRVBalanceBefore = IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    vm.startPrank(MICH_ADDRESS);
    IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).approve(SHORT_EXECUTOR, ACRV_AMOUNT);
    vm.stopPrank();

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 aUSDTBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 aCRVBalanceAfter = IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      aUSDTBalanceAfter,
      aUSDTBalanceBefore - USDT_AMOUNT,
      1500 ether,
      'aUSDT_LEFTOVER'
    );
    assertEq(aCRVBalanceAfter, aCRVBalanceBefore + ACRV_AMOUNT);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Eth_CRV_OTC_Deal_20230508',
      AaveV2Ethereum.POOL
    );

    e2eTest(AaveV2Ethereum.POOL);

    diffReports('preAaveV2_Eth_CRV_OTC_Deal_20230508', 'postAaveV2_Eth_CRV_OTC_Deal_20230508');
  }
}
