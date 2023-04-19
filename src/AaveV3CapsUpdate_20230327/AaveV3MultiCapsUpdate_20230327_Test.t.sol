// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthUpdate20230327Payload} from './AaveV3EthCapsUpdate_20230327.sol';
import {AaveV3ArbUpdate20230327Payload} from './AaveV3ArbCapsUpdate_20230327.sol';

contract AaveV3EthUpdate_20230327_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16920398);

    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestEthCapsUpdateMar27',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory crvBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.CRV_UNDERLYING
    );

    ReserveConfig memory rethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.rETH_UNDERLYING
    );

    _executePayload(address(new AaveV3EthUpdate20230327Payload()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestEthCapsUpdateMar27',
      AaveV3Ethereum.POOL
    );

    diffReports('preTestEthCapsUpdateMar27', 'postTestEthCapsUpdateMar27');

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3EthereumAssets.CRV_UNDERLYING;
    assetsChanged[1] = AaveV3EthereumAssets.rETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      crvBefore.supplyCap = 51_000_000;
      _validateReserveConfig(crvBefore, allConfigsAfter);
    }

    {
      rethBefore.supplyCap = 20_000;
      _validateReserveConfig(rethBefore, allConfigsAfter);
    }
  }
}


contract AaveV3ArbUpdate_20230327_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 74306378);

    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbCapsUpdateMar27',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory wethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );

    _executePayload(address(new AaveV3ArbUpdate20230327Payload()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestArbCapsUpdateMar27',
      AaveV3Arbitrum.POOL
    );

    diffReports('preTestArbCapsUpdateMar27', 'postTestArbCapsUpdateMar27');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3ArbitrumAssets.WETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      wethBefore.supplyCap = 45_000;
      _validateReserveConfig(wethBefore, allConfigsAfter);
    }
  }
}
