// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3AvaCapsUpdate_20230411} from './AaveV3AvaCapsUpdate_20230411.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3AvaCapsUpdate_20230411_Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3AvaCapsUpdate_20230411 public proposalPayload;

  address internal constant AVAX_GUARDIAN = 0xa35b76E4935449E33C56aB24b23fcd3246f13470;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 28584466);
    _selectPayloadExecutor(AVAX_GUARDIAN);
  }

  function testCapsAva() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Avalanche.POOL);

    createConfigurationSnapshot(
      'preAaveV3AvaCapsUpdate_20230411Change',
      AaveV3Avalanche.POOL
    );

    proposalPayload = new AaveV3AvaCapsUpdate_20230411();

    _executePayload(address(proposalPayload));

    createConfigurationSnapshot(
      'postAaveV3AvaCapsUpdate_20230411Change',
      AaveV3Avalanche.POOL
    );

    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Avalanche.POOL
    );

    address[] memory assetsChanged = new address[](3);
    assetsChanged[0] = AaveV3AvalancheAssets.BTCb_UNDERLYING;
    assetsChanged[1] = AaveV3AvalancheAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV3AvalancheAssets.DAIe_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory btcbConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.BTCb_UNDERLYING
    );
    btcbConfig.supplyCap = 3000;
    btcbConfig.borrowCap = 900;
    ProtocolV3TestBase._validateReserveConfig(btcbConfig, allConfigsAfter);

    ReserveConfig memory usdcConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.USDC_UNDERLYING
    );
    usdcConfig.supplyCap = 170_000_000;
    usdcConfig.borrowCap = 90_000_000;
    ProtocolV3TestBase._validateReserveConfig(usdcConfig, allConfigsAfter);

    ReserveConfig memory daiConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.DAIe_UNDERLYING
    );
    daiConfig.supplyCap = 17_000_000;
    daiConfig.borrowCap = 17_000_000;
    ProtocolV3TestBase._validateReserveConfig(daiConfig, allConfigsAfter);

    diffReports(
      'preAaveV3AvaCapsUpdate_20230411Change',
      'postAaveV3AvaCapsUpdate_20230411Change'
    );
  }
}
