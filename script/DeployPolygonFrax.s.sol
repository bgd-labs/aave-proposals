// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {FraxPayload} from '../src/contracts/polygon/FraxPayload.sol';

/**
* to deploy copy .env.example to .env and fill it, and then execute:
* source .env
* forge script ./script/DeployPolygonFrax.s.sol --fork-url $RPC_URL --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv
*/
contract DeployPolygonFrax is Script {
  function run() external {
    vm.startBroadcast();
    FraxPayload fraxPayload = new FraxPayload();
    console.log('Frax Payload address', address(fraxPayload));
    vm.stopBroadcast();
  }
}
