// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3ChaosLabsPaymentCollection_20230626} from 'src/AaveV3ChaosLabsPaymentCollection_20230626/AaveV3ChaosLabsPaymentCollection_20230626.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ChaosLabsPaymentCollection_20230626Test is Test {
  IERC20 public constant AAVE_ERC20 = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING);

  address public constant CHAOS_LABS = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  uint256 public constant PAYMENT_AMOUNT = 6541e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17561761);
  }

  function testExecute() public {
    uint256 initialChaosAAVEBalance = AAVE_ERC20.balanceOf(CHAOS_LABS);
    uint256 initialReserveAAVEBalance = AAVE_ERC20.balanceOf(AaveMisc.ECOSYSTEM_RESERVE);

    // execute proposal
    GovHelpers.executePayload(
      vm,
      address(new AaveV3ChaosLabsPaymentCollection_20230626()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    // Checking if ChaosLabs AAVE balance increased
    uint256 finalChaosAAVEBalance = AAVE_ERC20.balanceOf(CHAOS_LABS);
    uint256 finalReserveAAVEBalance = AAVE_ERC20.balanceOf(AaveMisc.ECOSYSTEM_RESERVE);
    assertEq(initialChaosAAVEBalance, finalChaosAAVEBalance - PAYMENT_AMOUNT);
    assertEq(initialReserveAAVEBalance, finalReserveAAVEBalance + PAYMENT_AMOUNT);
  }
}
