// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthLusdCapsPayload} from '../../contracts/mainnet/AaveV3EthLusdCapsPayload-Mar15.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3EthLusdCapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3EthLusdCapsPayload public proposalPayload;

  uint256 public constant LUSD_SUPPLY_CAP = 6_000_000;
  uint256 public constant LUSD_BORROW_CAP = 2_400_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16832165);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testLUSDCapsEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preLUSDCapsChange', AaveV3Ethereum.POOL);

    // 2. create payload
    proposalPayload = new AaveV3EthLusdCapsPayload();

    // 3. execute l2 payload
    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot('postLUSDCapsChange', AaveV3Ethereum.POOL);

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Ethereum.POOL
    );

    //LUSD
    ReserveConfig memory LUSDConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.LUSD_UNDERLYING
    );
    LUSDConfig.supplyCap = LUSD_SUPPLY_CAP;
    LUSDConfig.borrowCap = LUSD_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(LUSDConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preLUSDCapsChange', 'postLUSDCapsChange');
  }
}
