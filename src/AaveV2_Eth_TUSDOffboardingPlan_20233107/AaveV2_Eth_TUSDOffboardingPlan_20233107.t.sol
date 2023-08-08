// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Eth_TUSDOffboardingPlan_20233107} from './AaveV2_Eth_TUSDOffboardingPlan_20233107.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV2_Eth_TUSDOffboardingPlan_20233107
 * command: make test-contract filter=AaveV2_Eth_TUSDOffboardingPlan_20233107
 */
contract AaveV2_Eth_TUSDOffboardingPlan_20233107_Test is ProtocolV2TestBase {
  string public constant TUSD_SYMBOL = 'TUSD';

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17812148);
  }

  function testProposalExecution() public {
    AaveV2_Eth_TUSDOffboardingPlan_20233107 proposal = new AaveV2_Eth_TUSDOffboardingPlan_20233107();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Eth_TUSDOffboardingPlan_20233107',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory configTUSDBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      TUSD_SYMBOL
    );

    uint256 aTUSDBalanceBefore = IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 TUSDBalanceBefore = IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // check balances are correct
    uint256 aTUSDBalanceAfter = IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 TUSDBalanceAfter = IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    assertApproxEqAbs(aTUSDBalanceAfter, 0, 1500 ether, 'aTUSD_LEFTOVER');
    assertEq(TUSDBalanceAfter, aTUSDBalanceBefore + TUSDBalanceBefore);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Eth_TUSDOffboardingPlan_20233107',
      AaveV2Ethereum.POOL
    );

    // check it's not bricked
    ReserveConfig memory configTUSDAfter = _findReserveConfigBySymbol(allConfigsAfter, TUSD_SYMBOL);
    _withdraw(
      configTUSDAfter,
      AaveV2Ethereum.POOL,
      0x9FCc67D7DB763787BB1c7f3bC7f34d3C548c19Fe,
      1 ether
    ); // aTUSD whale

    // check there are no unexpected changes
    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configTUSDBefore.underlying
    );

    e2eTest(AaveV2Ethereum.POOL);

    diffReports(
      'preAaveV2_Eth_TUSDOffboardingPlan_20233107',
      'postAaveV2_Eth_TUSDOffboardingPlan_20233107'
    );
  }
}
