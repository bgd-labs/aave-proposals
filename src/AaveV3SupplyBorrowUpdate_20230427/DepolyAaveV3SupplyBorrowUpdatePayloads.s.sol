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
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](4);
    payloads[0] = GovHelpers.buildPolygon(address(0xac9AE3591c784275f452b5B9f7121a9122dc8Bfe));
    payloads[1] = GovHelpers.buildOptimism(address(0x050997fC08733EB8593c04102706d8D2e7A9443E));
    payloads[2] = GovHelpers.buildArbitrum(address(0xc53586AA2626094bD33C123794E34417ea877a36));
    payloads[3] = GovHelpers.buildMainnet(address(0x8070Dd4aee19048581D61543AdeCfa3Dd7F165C1));
    GovHelpers.createProposal(
      payloads,
      0x145c5e5f8f1806f069ad9eb41d0a6e8f15c6e04877102249785ebd0fd6caeb98,
      true
    );
  }
}