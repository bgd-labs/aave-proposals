// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.16;

// testing libraries
import 'forge-std/Test.sol';

// contract dependencies
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, ICollector, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3ChaosLabsPaymentCollection_20230626} from 'src/AaveV3ChaosLabsPaymentCollection_20230626/AaveV3ChaosLabsPaymentCollection_20230626.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ChaosLabsPaymentCollection_20230626Test is TestWithExecutor {
  IERC20 public constant AAVE_ERC20 = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING);

  ICollector public immutable AAVE_COLLECTOR = AaveV2Ethereum.COLLECTOR;
  address public constant CHAOS_LABS = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  uint256 public constant PAYMENT_AMOUNT = 6541 * 1e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17561761);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testExecute() public {
    uint256 initialChaosAAVEBalance = AAVE_ERC20.balanceOf(CHAOS_LABS);

    // execute proposal
    _executePayload(address(new AaveV3ChaosLabsPaymentCollection_20230626()));

    // Checking if ChaosLabs AAVE balance increased
    uint256 finalChaosAAVEBalance = AAVE_ERC20.balanceOf(CHAOS_LABS);
    assertEq(initialChaosAAVEBalance, finalChaosAAVEBalance - PAYMENT_AMOUNT);
    console.log('Chaos Labs AAVE balance increase');
    console.log((finalChaosAAVEBalance - initialChaosAAVEBalance) / 10 ** 18);
  }
}
