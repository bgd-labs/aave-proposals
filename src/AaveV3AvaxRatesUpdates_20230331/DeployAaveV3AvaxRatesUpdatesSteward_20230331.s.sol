pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3AvaRatesUpdatesSteward_20230331} from './AaveV3AvaxRatesUpdatesSteward_20230331.sol';

contract DeployPayloadAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3AvaRatesUpdatesSteward_20230331();
  }
}
