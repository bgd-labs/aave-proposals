// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

interface ICRVDepositor {
    /// @notice Deposit & Lock Token
	/// @dev User needs to approve the contract to transfer the token
	/// @param _amount The amount of token to deposit
	/// @param _lock Whether to lock the token
	/// @param _stake Whether to stake the token
	/// @param _user User to deposit for
	function deposit(
		uint256 _amount,
		bool _lock,
		bool _stake,
		address  _user
	) external;
}

contract AaveV3EthsdCRV_20230503_Payload is IProposalGenericExecutor {
    address public constant CRV_DEPOSITOR = 0xc1e3Ca8A3921719bE0aE3690A0e036feB4f69191;

    function execute() external {
        /*******************************************************************************
        ******************************** Withdraw Tokens *******************************
        *******************************************************************************/
        AaveV2Ethereum.COLLECTOR.transfer(
            AaveV2EthereumAssets.CRV_A_TOKEN,
            address(this),
            IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR))
        );

        AaveV2Ethereum.COLLECTOR.transfer(
            AaveV2EthereumAssets.CRV_UNDERLYING,
            address(this),
            IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR))
        );

        AaveV2Ethereum.POOL.withdraw(
            AaveV2EthereumAssets.CRV_UNDERLYING,
            type(uint256).max,
            address(this)
        );

        /*******************************************************************************
        *********************************** Deposit ***********************************
        *******************************************************************************/
        uint256 balance = IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(address(this));
        
        IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).approve(CRV_DEPOSITOR, balance);

        ICRVDepositor(CRV_DEPOSITOR).deposit(balance, true, false, address(AaveV2Ethereum.COLLECTOR));
    }
}
