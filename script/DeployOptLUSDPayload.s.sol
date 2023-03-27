pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV3OptLUSDPayload} from '../src/contracts/optimism/AaveV3OptLUSDPayload.sol';

contract DeployOptimismPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(10) {}
}

contract Op is DeployOptimismPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3OptLUSDPayload();
    vm.stopBroadcast();
  }
}
