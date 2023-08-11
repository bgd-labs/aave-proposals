// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';


/**
 * @title Chaos Labs Risk Parameter Updates - CRV Aave V2 Ethereum
 * @author @omeragoldberg - ChaosLabsInc
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0x8b992ee05d9e87ef0dab2cb7178c24f7b4b6f5d79561ad33298550b3c8d9fe89
 * - Discussion: https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/47
 */
contract AaveV2_Eth_CRVLTUpdate_20230806 is IProposalGenericExecutor{
    uint256 public constant CRV_LIQUIDATION_THRESHOLD = 49_00; // 55 -> 49
    uint256 public constant CRV_LTV = 0; // unchanged 
    uint256 public constant CRV_LIQUIDATION_BONUS = 10800; // unchanged

    function execute() external {
        AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
            AaveV2EthereumAssets.CRV_UNDERLYING,
            CRV_LTV,
            CRV_LIQUIDATION_THRESHOLD,
            CRV_LIQUIDATION_BONUS  
        );
    }
}