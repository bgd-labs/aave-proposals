// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3EthDFSFlashBorrowActivation} from 'src/AaveV3DFSFlashBorrow_20230403/AaveV3ETHDFSFlashBorrowActivation_20230403.sol';
import {AaveV3ARBDFSFlashBorrowActivation} from 'src/AaveV3DFSFlashBorrow_20230403/AaveV3ARBDFSFlashBorrowActivation_20230403.sol';
import {AaveV3OptDFSFlashBorrowActivation} from 'src/AaveV3DFSFlashBorrow_20230403/AaveV3OptDFSFlashBorrowActivation_20230403.sol';

contract DFSMainnetPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3EthDFSFlashBorrowActivation();
  }
}

contract DFSArbitrumPayload is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ARBDFSFlashBorrowActivation();
  }
}

contract DFSOptimismPayload is OptimismScript {
  function run() external broadcast {
    new AaveV3OptDFSFlashBorrowActivation();
  }
}
