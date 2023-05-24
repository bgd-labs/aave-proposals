// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

import {AaveCOWTrader} from './AaveCOWTrader.sol';

contract DeployAaveCOWTraderScript is EthereumScript {
    function run() external broadcast {
        new AaveCOWTrader();
    }
}
