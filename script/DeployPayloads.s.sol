// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3EthcbETHPayload} from '../src/contracts/mainnet/AaveV3EthcbETHPayload.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';

contract DeployCbETH is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthcbETHPayload();
    vm.stopBroadcast();
  }
}
