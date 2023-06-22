// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;


import {ProtocolV3_0_1TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV3StrategicAssets_20220622Payload} from './AaveV3StrategicAssets_20220622Payload.sol';

contract AaveV3StrategicAssets_20220622PayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
    AaveV3StrategicAssets_20220622Payload payload;

    function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17536310);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3StrategicAssets_20220622Payload();
  }

    function test_payloadExecution() public {

    }
}
