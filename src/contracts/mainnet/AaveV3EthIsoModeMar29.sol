// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
* @dev change 4 stable asset to be in borrowable isolation mode - usdc, usdt, dai and lusd
* - Discussion: https://governance.aave.com/t/arfc-configure-isolation-mode-borrowable-assets-v3-ethereum/12420
*/
contract AaveV3EthIsoModeMar29 is IProposalGenericExecutor {
     bool public constant USDC_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

     bool public constant USDT_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

     bool public constant DAI_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

     bool public constant LUSD_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

    function execute() external {
         AaveV3Ethereum.POOL_CONFIGURATOR.setBorrowableInIsolation(AaveV3EthereumAssets.USDC_UNDERLYING, USDC_UNDERLYING_BORROWABLE_IN_ISOLATION);
         AaveV3Ethereum.POOL_CONFIGURATOR.setBorrowableInIsolation(AaveV3EthereumAssets.USDT_UNDERLYING, USDT_UNDERLYING_BORROWABLE_IN_ISOLATION);
         AaveV3Ethereum.POOL_CONFIGURATOR.setBorrowableInIsolation(AaveV3EthereumAssets.DAI_UNDERLYING, DAI_UNDERLYING_BORROWABLE_IN_ISOLATION);
         AaveV3Ethereum.POOL_CONFIGURATOR.setBorrowableInIsolation(AaveV3EthereumAssets.LUSD_UNDERLYING, LUSD_UNDERLYING_BORROWABLE_IN_ISOLATION);

    }
}