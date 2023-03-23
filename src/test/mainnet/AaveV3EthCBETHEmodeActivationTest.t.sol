// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthCBETHEmodeActivation} from '../../contracts/mainnet/AaveV3EthCBETHEmodeActivation.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3EthCBETHEmodeActivationTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3EthCBETHEmodeActivation public proposalPayload;

  address public constant CBETH = AaveV3EthereumAssets.cbETH_UNDERLYING;

  uint256 public constant EMODE_CATEGORY = 1;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16777040);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testEMODEcbEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('precbETHEmodeActivation', AaveV3Ethereum.POOL);

    // 2. create payload
    proposalPayload = new AaveV3EthCBETHEmodeActivation();

    // 3. execute payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot('postcbETHEmodeActivation', AaveV3Ethereum.POOL);

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Ethereum.POOL
    );

    //CBETH
    ReserveConfig memory CBETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      CBETH
    );
    CBETHConfig.eModeCategory = EMODE_CATEGORY;
    ProtocolV3TestBase._validateReserveConfig(CBETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports('precbETHEmodeActivation', 'postcbETHEmodeActivation');
  }
}
