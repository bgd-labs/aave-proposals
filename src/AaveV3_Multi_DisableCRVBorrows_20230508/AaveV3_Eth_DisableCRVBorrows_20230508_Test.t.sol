pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2 } from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_DisableCRVBorrows_20230508} from './AaveV3_Eth_DisableCRVBorrows_20230508.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3_Eth_DisableCRVBorrows_20230508_Test is ProtocolV3TestBase {
    AaveV3_Eth_DisableCRVBorrows_20230508 public proposalPayload;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl('mainnet'), 17847788);
        proposalPayload = new AaveV3_Eth_DisableCRVBorrows_20230508();
    }

    function testBorrowingEnabled() public {
        ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
            'pre-Aave-V3-Etherum-CRV-Updates-20230805',
            AaveV3Ethereum.POOL
        );

        ReserveConfig memory crvConfig = ProtocolV3TestBase._findReserveConfig(
            allConfigsBefore,
            AaveV3EthereumAssets.CRV_UNDERLYING
        );
        crvConfig.borrowingEnabled = false;

        // 1. deploy payload
        proposalPayload = new AaveV3_Eth_DisableCRVBorrows_20230508();

        // 2. execute payload
        GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

        ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
            AaveV3Ethereum.POOL
        );

        ProtocolV3TestBase._validateReserveConfig(crvConfig, allConfigsAfter);
    }
}