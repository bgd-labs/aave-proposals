// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IACLManager, IPoolConfigurator, IPoolDataProvider, IPool} from 'aave-address-book/AaveV3.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3Optimism, AaveV3Arbitrum, AaveV3Avalanche, AaveV3Polygon, AaveV3Metis} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3RiskSteward_20230404} from './AaveV3RiskSteward_20230404.sol';
import {CapsPlusRiskSteward} from 'aave-helpers/riskstewards/CapsPlusRiskSteward.sol';
import {ICapsPlusRiskSteward} from 'aave-helpers/riskstewards/ICapsPlusRiskSteward.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

abstract contract StewardTestBase is ProtocolV3_0_1TestBase, TestWithExecutor {
  IPoolDataProvider immutable AAVE_PROTOCOL_DATA_PROVIDER;
  IPool immutable POOL;
  address immutable CAPS_PLUS_RISK_STEWARD;
  IACLManager immutable ACL_MANAGER;

  AaveV3RiskSteward_20230404 proposalPayload;

  constructor(IPoolDataProvider pdp, IPool pool, address steward, IACLManager aclManager) {
    AAVE_PROTOCOL_DATA_PROVIDER = pdp;
    POOL = pool;
    CAPS_PLUS_RISK_STEWARD = steward;
    ACL_MANAGER = aclManager;
  }

  function _setup(address executor) internal {
    proposalPayload = new AaveV3RiskSteward_20230404(ACL_MANAGER, CAPS_PLUS_RISK_STEWARD);

    _selectPayloadExecutor(executor);
    _executePayload(address(proposalPayload));
  }

  function test_increaseCapsMax() public {
    address[] memory reserves = POOL.getReservesList();
    (uint256 borrowCapBefore, uint256 supplyCapBefore) = AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      reserves[0]
    );

    IAaveV3ConfigEngine.CapsUpdate[] memory capUpdates = new IAaveV3ConfigEngine.CapsUpdate[](1);
    capUpdates[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: reserves[0],
      supplyCap: supplyCapBefore * 2,
      borrowCap: borrowCapBefore * 2
    });

    ICapsPlusRiskSteward steward = ICapsPlusRiskSteward(proposalPayload.STEWARD());

    vm.startPrank(steward.RISK_COUNCIL());
    steward.updateCaps(capUpdates);

    (uint256 borrowCapAfter, uint256 supplyCapAfter) = AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      reserves[0]
    );

    ICapsPlusRiskSteward.Debounce memory debounce = steward.getTimelock(reserves[0]);
    assertEq(borrowCapAfter, capUpdates[0].borrowCap);
    assertEq(supplyCapAfter, capUpdates[0].supplyCap);
    assertEq(debounce.supplyCapLastUpdated, block.timestamp);
    assertEq(debounce.borrowCapLastUpdated, block.timestamp);
  }
}

contract EthAaveV3RiskSteward_20230321_Test is StewardTestBase {
  constructor()
    StewardTestBase(
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Ethereum.POOL,
      AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD,
      AaveV3Ethereum.ACL_MANAGER
    )
  {}

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17322108);
    _setup(AaveGovernanceV2.SHORT_EXECUTOR);
  }
}

contract OptAaveV3RiskSteward_20230321_Test is StewardTestBase {
  constructor()
    StewardTestBase(
      AaveV3Optimism.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Optimism.POOL,
      AaveV3Optimism.CAPS_PLUS_RISK_STEWARD,
      AaveV3Optimism.ACL_MANAGER
    )
  {}

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 100771219);
    _setup(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }
}

contract ArbAaveV3RiskSteward_20230321_Test is StewardTestBase {
  constructor()
    StewardTestBase(
      AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Arbitrum.POOL,
      AaveV3Arbitrum.CAPS_PLUS_RISK_STEWARD,
      AaveV3Arbitrum.ACL_MANAGER
    )
  {}

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 93616937);
    _setup(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }
}

contract AvaAaveV3RiskSteward_20230321_Test is StewardTestBase {
  constructor()
    StewardTestBase(
      AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Avalanche.POOL,
      AaveV3Avalanche.CAPS_PLUS_RISK_STEWARD,
      AaveV3Avalanche.ACL_MANAGER
    )
  {}

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 30391834);
    _setup(AaveV3Avalanche.ACL_ADMIN);
  }
}

contract PolAaveV3RiskSteward_20230321_Test is StewardTestBase {
  constructor()
    StewardTestBase(
      AaveV3Polygon.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Polygon.POOL,
      AaveV3Polygon.CAPS_PLUS_RISK_STEWARD,
      AaveV3Polygon.ACL_MANAGER
    )
  {}

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 43052754);
    _setup(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }
}

contract MetAaveV3RiskSteward_20230321_Test is StewardTestBase {
  constructor()
    StewardTestBase(
      AaveV3Metis.AAVE_PROTOCOL_DATA_PROVIDER,
      AaveV3Metis.POOL,
      AaveV3Metis.CAPS_PLUS_RISK_STEWARD,
      AaveV3Metis.ACL_MANAGER
    )
  {}

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 5783096);
    _setup(AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);
  }
}
