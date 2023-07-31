// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {AvalancheScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3AvaxretrofundingPayload} from 'src/AaveV3AvaxretrofundingPayload_20230626/AaveV3AvaxretrofundingPayload_20230626.sol';

contract DeployAvaxRetroPayload is AvalancheScript {
  function run() external broadcast {
    new AaveV3AvaxretrofundingPayload();
  }
}