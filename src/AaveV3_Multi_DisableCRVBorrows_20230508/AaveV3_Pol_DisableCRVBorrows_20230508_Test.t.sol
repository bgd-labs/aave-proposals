pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_DisableCRVBorrows_20230508} from './AaveV3_Pol_DisableCRVBorrows_20230508.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3_Pol_DisableCRVBorrows_20230508_Test is ProtocolV3TestBase {
    AaveV3_Pol_DisableCRVBorrows_20230508 public proposalPayload;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl('polygon'), 45916841);
        proposalPayload = new AaveV3_Pol_DisableCRVBorrows_20230508();
    }

    function testBorrowingEnabled() public {
        ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
            'pre-Aave-V3-Polygon-CRV-Updates-20230805',
            AaveV3Polygon.POOL
        );

        ReserveConfig memory crvConfig = ProtocolV3TestBase._findReserveConfig(
            allConfigsBefore,
            AaveV3PolygonAssets.CRV_UNDERLYING
        );
        crvConfig.borrowingEnabled = false;

        // 1. deploy l2 payload
        proposalPayload = new AaveV3_Pol_DisableCRVBorrows_20230508();

        // 2. execute l2 payload
        GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

        ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
            AaveV3Polygon.POOL
        );

        ProtocolV3TestBase._validateReserveConfig(crvConfig, allConfigsAfter);
    }
}