// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV2EthAGDGrantsPayload} from './AaveV2EthAGDGrantsPayload.sol';

contract AaveV2EthAGDGrantsPayloadTest is ProtocolV2TestBase {
  AaveV2EthAGDGrantsPayload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17180572);
    payload = new AaveV2EthAGDGrantsPayload();
  }

  function test_execute() public {
    // AGD Approvals Pre-Execution
    assertEq(
      IERC20(payload.aUSDTV1()).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        payload.AGD_MULTISIG()
      ),
      payload.AMOUNT_AUSDT()
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        payload.AGD_MULTISIG()
      ),
      0
    );
    // End AGD Approvals Pre-Execution

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // AGD Approvals Post-Execution
    assertEq(
      IERC20(payload.aUSDTV1()).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        payload.AGD_MULTISIG()
      ),
      0
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV2Ethereum.COLLECTOR),
        payload.AGD_MULTISIG()
      ),
      payload.AMOUNT_AUSDT()
    );

    vm.startPrank(payload.AGD_MULTISIG());
    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transferFrom(
      address(AaveV2Ethereum.COLLECTOR),
      makeAddr('new-addy'),
      payload.AMOUNT_AUSDT()
    );
    vm.stopPrank();
    // End AGD Approvals Post-Execution
  }
}
