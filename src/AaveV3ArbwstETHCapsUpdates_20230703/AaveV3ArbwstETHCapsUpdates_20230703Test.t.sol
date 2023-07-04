// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbwstETHCapsUpdates_20230703} from './AaveV3ArbwstETHCapsUpdates_20230703.sol';

contract AaveV3ArbwstETHCapsUpdates_20230703_Test is ProtocolV3TestBase {
  AaveV3ArbwstETHCapsUpdates_20230703 public payload;
  uint256 public constant NEW_SUPPLY_CAP_WSTETH = 30_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 107412640);
    payload = new AaveV3ArbwstETHCapsUpdates_20230703();
  }

  function testCapsUpdates() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Arbitrum-wstETH-Supply-Cap-Update-20230703',
      AaveV3Arbitrum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-wstETH-Supply-Cap-Update-20230703',
      AaveV3Arbitrum.POOL
    );

    // 4. verify payload:
    ReserveConfig memory WSTETH_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.wstETH_UNDERLYING
    );

    WSTETH_CONFIG.supplyCap = NEW_SUPPLY_CAP_WSTETH;

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3ArbitrumAssets.wstETH_UNDERLYING
    );

    _validateReserveConfig(WSTETH_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'pre-Aave-V3-Arbitrum-wstETH-Supply-Cap-Update-20230703',
      'post-Aave-V3-Arbitrum-wstETH-Supply-Cap-Update-20230703'
    );

    // 6. e2e
    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.wstETH_UNDERLYING)
    );
  }
}
