// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthLUSDPayload} from '../../contracts/mainnet/AaveV3EthLusdPayload.sol';

contract AaveV3EthLUSDPayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16633440);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3EthLUSDPayload LUSD = new AaveV3EthLUSDPayload();

    createConfigurationSnapshot('preLUSD', AaveV3Ethereum.POOL);

    _executePayload(address(LUSD));

    createConfigurationSnapshot('postLUSD', AaveV3Ethereum.POOL);

<<<<<<< HEAD
    // diffReports('preLUSD', 'postLUSD');
=======
    diffReports('preLUSD', 'postLUSD');
>>>>>>> 7c5ba990e9fcebc6388caf28d2d602067bb5de96
  }
}
