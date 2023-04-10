// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthereumScript} from 'aave-helpers/../script/Utils.s.sol';
import {MockSwap} from './MockSwap.sol';

contract ExampleMainnetPayload is EthereumScript {
  function run() external broadcast {
    new MockSwap();
  }
}
