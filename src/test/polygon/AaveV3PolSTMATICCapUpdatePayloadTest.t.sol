// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolSTMATICCapUpdatePayload} from '../../contracts/polygon/AaveV3PolSTMATICCapUpdatePayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolSTMATICCapUpdatePayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolSTMATICCapUpdatePayload public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39737420);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testCapsPol() public {
    createConfigurationSnapshot('pre-stMatic-SupplyCap-Aave-V3-Polygon', AaveV3Polygon.POOL);

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolSTMATICCapUpdatePayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Polygon.POOL);

    //stMATIC
    ReserveConfig memory STMATICConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );
    STMATICConfig.supplyCap = proposalPayload.STMATIC_SUPPLY_CAP();
    _validateReserveConfig(STMATICConfig, allConfigsAfter);

    createConfigurationSnapshot('post-stMatic-SupplyCap-Aave-V3-Polygon', AaveV3Polygon.POOL);
    diffReports('pre-stMatic-SupplyCap-Aave-V3-Polygon', 'post-stMatic-SupplyCap-Aave-V3-Polygon');
  }
}
