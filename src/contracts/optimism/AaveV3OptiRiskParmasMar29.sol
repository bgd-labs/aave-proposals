// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
* @dev This proposal changes WBTC and DAI risk params
* - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-optimism-2023-03-22/12421
*/
contract AaveV3OptiRiskParmasMar29 is IProposalGenericExecutor {
    uint256 public constant WBTC_UNDERLYING_LIQ_THRESHOLD = 7800; // 78.0%
    uint256 public constant WBTC_UNDERLYING_LTV = 7300; // 73.0%
    uint256 public constant WBTC_UNDERLYING_LIQ_BONUS = 10850; // 8.5%

    uint256 public constant DAI_UNDERLYING_LIQ_THRESHOLD = 8300; // 83.0%
    uint256 public constant DAI_UNDERLYING_LTV = 7800; // 78.0%
    uint256 public constant DAI_UNDERLYING_LIQ_BONUS = 10500; // 5.0% Not Changed


    function execute() external {
        AaveV3Optimism.POOL_CONFIGURATOR.configureReserveAsCollateral(
            AaveV3OptimismAssets.WBTC_UNDERLYING,
            WBTC_UNDERLYING_LTV,
            WBTC_UNDERLYING_LIQ_THRESHOLD,
            WBTC_UNDERLYING_LIQ_BONUS
        ); 
        AaveV3Optimism.POOL_CONFIGURATOR.configureReserveAsCollateral(
            AaveV3OptimismAssets.DAI_UNDERLYING,
            DAI_UNDERLYING_LTV,
            DAI_UNDERLYING_LIQ_THRESHOLD,
            DAI_UNDERLYING_LIQ_BONUS
        ); 

    }
}
