// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3OPSupplyBorrowUpdate_20230427} from './AaveV3OPSupplyBorrowUpdate_20230427.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3OPSupplyBorrowUpdate_20230427Test is ProtocolV3LegacyTestBase {
  AaveV3OPSupplyBorrowUpdate_20230427 public proposalPayload;

  uint256 public constant WBTC_SUPPLY_CAP = 1_200;

  uint256 public constant wstETH_SUPPLY_CAP = 12_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 84098323);
  }

  function testSupplyCapsEth() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3OPSupplyBorrowUpdate_20230427Change',
      AaveV3Optimism.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3OPSupplyBorrowUpdate_20230427();

    // 3. execute payload

    GovHelpers.executePayload(
      vm,
      address(proposalPayload),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    // 4. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3OPSupplyBorrowUpdate_20230427Change',
      AaveV3Optimism.POOL
    );

    //Verify payload:
    //WBTC
    ReserveConfig memory WBTCConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.WBTC_UNDERLYING
    );
    WBTCConfig.supplyCap = WBTC_SUPPLY_CAP;
    _validateReserveConfig(WBTCConfig, allConfigsAfter);

    //wstETH
    ReserveConfig memory wstETHConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.wstETH_UNDERLYING
    );
    wstETHConfig.supplyCap = wstETH_SUPPLY_CAP;
    _validateReserveConfig(wstETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3OPSupplyBorrowUpdate_20230427Change',
      'postAaveV3OPSupplyBorrowUpdate_20230427Change'
    );
  }
}
