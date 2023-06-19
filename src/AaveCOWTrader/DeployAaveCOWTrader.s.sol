// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

import {AaveCurator} from './AaveCurator.sol';

contract DeployAaveCuratorScript is EthereumScript {
    function run() external broadcast {
        new AaveCurator();
    }
}
