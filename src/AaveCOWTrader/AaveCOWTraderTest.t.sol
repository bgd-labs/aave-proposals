// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveCOWTrader} from './AaveCOWTrader.sol';

contract AaveCOWTraderTest is Test {
    AaveCOWTrader private trader = new AaveCOWTrader();
}
