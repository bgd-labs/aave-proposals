// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3PolFreezeAGEUR} from '../../contracts/polygon/AaveV3PolFreezeAGEUR.sol';
import {AaveV3PolFreezeJEUR} from '../../contracts/polygon/AaveV3PolFreezeJEUR.sol';
import {BaseTest} from '../utils/BaseTest.sol';

contract AaveV3PolJEURAGEURFreeze is ProtocolV3TestBase, BaseTest {
  string public constant JEUR_SYMBOL = 'jEUR';
  string public constant AGEUR_SYMBOL = 'agEUR';

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 38225470);
    _setUp(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testJEUR() public {
    createConfigurationSnapshot('pre-jEUR-freezing', AaveV3Polygon.POOL);
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory configJEURBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      JEUR_SYMBOL
    );

    address jEURPayload = address(new AaveV3PolFreezeJEUR());

    _execute(jEURPayload);

    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    configJEURBefore.isFrozen = true;

    _validateReserveConfig(configJEURBefore, allConfigsAfter);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configJEURBefore.underlying
    );

    createConfigurationSnapshot('post-jEUR-freezing', AaveV3Polygon.POOL);
  }

  function testAGEUR() public {
    createConfigurationSnapshot('pre-agEUR-freezing', AaveV3Polygon.POOL);

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory configAGEURBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      AGEUR_SYMBOL
    );

    address agEURPayload = address(new AaveV3PolFreezeAGEUR());

    _execute(agEURPayload);

    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    configAGEURBefore.isFrozen = true;

    _validateReserveConfig(configAGEURBefore, allConfigsAfter);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configAGEURBefore.underlying
    );
    createConfigurationSnapshot('post-agEUR-freezing', AaveV3Polygon.POOL);
  }
}
