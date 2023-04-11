pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AvalancheScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3AvaCapsUpdate_20230411} from './AaveV3AvaCapsUpdate_20230411.sol';


contract DeployPayloadAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3AvaCapsUpdate_20230411();
  }
}
