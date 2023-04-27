// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {ArbitrumScript, OptimismScript, PolygonScript, EthereumScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3POLSupplyBorrowUpdate_20230427} from './AaveV3POLSupplyBorrowUpdate_20230427.sol';
import {AaveV3OPSupplyBorrowUpdate_20230427} from './AaveV3OPSupplyBorrowUpdate_20230427.sol';
import {AaveV3AVASupplyBorrowUpdate_20230427} from './AaveV3AVASupplyBorrowUpdate_20230427.sol';
import {AaveV3ETHSupplyBorrowUpdate_20230427} from './AaveV3ETHSupplyBorrowUpdate_20230427.sol';
import {AaveV3ARBSupplyBorrowUpdate_20230427} from './AaveV3ARBSupplyBorrowUpdate_20230427.sol';


contract DeployAaveV3POLSupplyBorrowUpdate_20230427 is PolygonScript {
  function run() external broadcast {
    new AaveV3POLSupplyBorrowUpdate_20230427();
  }
}

contract DeployAaveV3OPSupplyBorrowUpdate_20230427 is OptimismScript {
  function run() external broadcast {
    new AaveV3OPSupplyBorrowUpdate_20230427();
  }
}

contract DeployAaveV3AVASupplyBorrowUpdate_20230427 is AvalancheScript {
  function run() external broadcast {
    new AaveV3AVASupplyBorrowUpdate_20230427();
  }
}

contract DeployAaveV3ETHSupplyBorrowUpdate_20230427 is EthereumScript {
  function run() external broadcast {
    new AaveV3ETHSupplyBorrowUpdate_20230427();
  }
}

contract DeployAaveV3ARBSupplyBorrowUpdate_20230427 is ArbitrumScript {
  function run() external broadcast {
    new AaveV3ARBSupplyBorrowUpdate_20230427();
  }
}

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](5);
    payloads[0] = GovHelpers.buildPolygon(address(0)); // deployed payload
    payloads[1] = GovHelpers.buildOptimism(address(0)); // deployed payload
    payloads[2] = GovHelpers.buildArbitrum(address(0)); // deployed payload
    payloads[3] = GovHelpers.buildMainnet(address(0)); // deployed payload
    GovHelpers.createProposal(
      payloads,
      0, // TODO: Replace with actual hash
      true
    );
  }
}