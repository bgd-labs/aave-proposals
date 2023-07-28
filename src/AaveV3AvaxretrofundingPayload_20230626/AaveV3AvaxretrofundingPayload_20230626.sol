// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;


import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';


/**
 * @title AAVE V3 AVAX Retro funding proposal
 * @author @marczeller - Aave-Chan Initiative
 * Governance Forum Post: https://governance.aave.com/t/arc-aave-v3-retroactive-funding/9250
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/bafkreia45d5m6y3o4b476ykp6q65v3zlecxvz6h57tdfhowqm5wb5nzdvq
 */
contract AaveV3AvaxretrofundingPayload is IProposalGenericExecutor {
    address public constant AAVECO_ADDRESS = 0xa8F8E9c54e099c4fADB797f5196E07ce484824aF;
    address public constant aAvaWAVAX = AaveV3AvalancheAssets.WAVAX_A_TOKEN;
    address public constant avWAVAX = 0xDFE521292EcE2A4f44242efBcD66Bc594CA9714B;
    address public constant aAvaWBTC = AaveV3AvalancheAssets.WBTCe_A_TOKEN;
    address public constant avWBTC = 0x686bEF2417b6Dc32C50a3cBfbCC3bb60E1e9a15D;
    
    uint256 public constant AMOUNT_aAvaWAVAX = 9_584_301837000000000000;
    uint256 public constant AMOUNT_avWAVAX = 19_415_698163000000000000;

    uint256 public constant AMOUNT_aAvaWBTC = 1_07727500;
    uint256 public constant AMOUNT_avWBTC = 1_80714600;


    function execute() external {
        AaveV3Avalanche.COLLECTOR.transfer(aAvaWAVAX, AAVECO_ADDRESS, AMOUNT_aAvaWAVAX);
        AaveV3Avalanche.COLLECTOR.transfer(avWAVAX, AAVECO_ADDRESS, AMOUNT_avWAVAX);
        AaveV3Avalanche.COLLECTOR.transfer(aAvaWBTC, AAVECO_ADDRESS, AMOUNT_aAvaWBTC);
        AaveV3Avalanche.COLLECTOR.transfer(avWBTC, AAVECO_ADDRESS, AMOUNT_avWBTC);
    }
}