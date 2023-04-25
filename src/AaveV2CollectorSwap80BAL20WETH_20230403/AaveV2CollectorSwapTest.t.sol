// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {console2} from 'forge-std/Test.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {SwapFor80BAL20WETHPayload} from './AaveV2CollectorSwap80BAL20WETH_20230403_Payload.sol';

contract SwapFor80BAL20WETHPayloadTest is ProtocolV3TestBase, TestWithExecutor {
    SwapFor80BAL20WETHPayload payload;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("mainnet"), 17123211);
        _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

        payload = new SwapFor80BAL20WETHPayload();
    }

    function test_AGDApproval() public {
        assertEq(IERC20(payload.aUSDTV1()).allowance(address(AaveV2Ethereum.COLLECTOR), payload.AGD_MULTISIG()), payload.AMOUNT_AUSDT());
        assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(address(AaveV2Ethereum.COLLECTOR), payload.AGD_MULTISIG()), 0);

        _executePayload(address(payload));

        assertEq(IERC20(payload.aUSDTV1()).allowance(address(AaveV2Ethereum.COLLECTOR), payload.AGD_MULTISIG()), 0);
        assertEq(IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).allowance(address(AaveV2Ethereum.COLLECTOR), payload.AGD_MULTISIG()), payload.AMOUNT_AUSDT());

        vm.startPrank(payload.AGD_MULTISIG());
        IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).transferFrom(address(AaveV2Ethereum.COLLECTOR), makeAddr("new-addy"), payload.AMOUNT_AUSDT());
        vm.stopPrank();
    }

    function test_swap() public {

    }
}