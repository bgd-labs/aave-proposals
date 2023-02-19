// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthCbETHCapsPayload} from '../../contracts/mainnet/AaveV3EthCBETHCapsPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3EthCbETHCapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3EthCbETHCapsPayload public proposalPayload;

  address public constant CBETH = AaveV3EthereumAssets.cbETH_UNDERLYING;

  uint256 public constant CBETH_SUPPLY_CAP = 20_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16661298);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testSupplyCapsEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('precbETHCapChange', AaveV3Ethereum.POOL);

    // 2. create payload
    proposalPayload = new AaveV3EthCbETHCapsPayload();

    // 3. execute l2 payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot('postcbETHCapChange', AaveV3Ethereum.POOL);

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Ethereum.POOL
    );

    //CBETH
    ReserveConfig memory CBETHConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, CBETH);
    CBETHConfig.supplyCap = CBETH_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(CBETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports('precbETHCapChange', 'postcbETHCapChange');
  }
}
