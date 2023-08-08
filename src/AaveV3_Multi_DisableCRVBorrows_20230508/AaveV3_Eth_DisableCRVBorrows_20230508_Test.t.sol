// SPDX-License-Identifier: MIT
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
        proposalPayload = new AaveV3_Eth_DisableCRVBorrows_20230508();

        // 1. create snapshot before payload execution
        ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
            'pre-Aave-V3-Etherum-CRV-Updates-20230805',
            AaveV3Ethereum.POOL
        );

        // 2. execute payload
        GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

        // 3. create snapshot after payload execution
        ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
            'post-Aave-V3-Etherum-CRV-Updates-20230805',
            AaveV3Ethereum.POOL
        );

        // 4. Verify payload:
        ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
            allConfigsBefore,
            AaveV3EthereumAssets.CRV_UNDERLYING
        );
        CRV_UNDERLYING_CONFIG.borrowingEnabled = false;
        _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

        // 5. compare snapshots
        diffReports(
            'pre-Aave-V3-Etherum-CRV-Updates-20230805',
            'post-Aave-V3-Etherum-CRV-Updates-20230805'
        );

        // 6. e2e
        e2eTestAsset(
            AaveV3Ethereum.POOL,
            _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.WETH_UNDERLYING),
            _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.CRV_UNDERLYING)
        );

    }
}