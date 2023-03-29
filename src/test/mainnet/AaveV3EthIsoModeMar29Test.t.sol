// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthIsoModeMar29} from '../../../src/contracts/mainnet/AaveV3EthIsoModeMar29.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3EthIsoModeMar29Test is ProtocolV3TestBase, TestWithExecutor {
    bool public constant USDC_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

    bool public constant USDT_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

    bool public constant DAI_UNDERLYING_BORROWABLE_IN_ISOLATION = true;

    bool public constant LUSD_UNDERLYING_BORROWABLE_IN_ISOLATION = true;


    function setUp() public {
        vm.createSelectFork(vm.rpcUrl('mainnet'), 16925078);
        _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    }

    function testPayload() public {
        AaveV3EthIsoModeMar29 proposalPayload = new AaveV3EthIsoModeMar29();

        ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

        // execute payload
        _executePayload(address(proposalPayload));

        //Verify payload:
        ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Ethereum.POOL);
        

        ReserveConfig memory USDC_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
        allConfigsBefore,
        AaveV3EthereumAssets.USDC_UNDERLYING
        );
        
        USDC_UNDERLYING_CONFIG.isBorrowableInIsolation = USDC_UNDERLYING_BORROWABLE_IN_ISOLATION;
        ProtocolV3TestBase._validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);

        ReserveConfig memory USDT_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
        allConfigsBefore,
        AaveV3EthereumAssets.USDT_UNDERLYING
        );
        
        USDT_UNDERLYING_CONFIG.isBorrowableInIsolation = USDT_UNDERLYING_BORROWABLE_IN_ISOLATION;
        ProtocolV3TestBase._validateReserveConfig(USDT_UNDERLYING_CONFIG, allConfigsAfter);

        ReserveConfig memory DAI_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
        allConfigsBefore,
        AaveV3EthereumAssets.DAI_UNDERLYING
        );
        
        DAI_UNDERLYING_CONFIG.isBorrowableInIsolation = DAI_UNDERLYING_BORROWABLE_IN_ISOLATION;
        ProtocolV3TestBase._validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);

        ReserveConfig memory LUSD_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
        allConfigsBefore,
        AaveV3EthereumAssets.LUSD_UNDERLYING
        );
        
        LUSD_UNDERLYING_CONFIG.isBorrowableInIsolation = LUSD_UNDERLYING_BORROWABLE_IN_ISOLATION;
        ProtocolV3TestBase._validateReserveConfig(LUSD_UNDERLYING_CONFIG, allConfigsAfter);
    }
}
