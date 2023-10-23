// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018} from './AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018.sol';

/**
 * @dev Deploy AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018
 * command: make deploy-ledger contract=src/20231018_AaveV3_Pol_TransferAssetsFromPolygonToEthereumTreasury/AaveV3_TransferAssetsFromPolygonToEthereumTreasury_20231018.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231018_AaveV3_Pol_TransferAssetsFromPolygonToEthereumTreasury/AaveV3_TransferAssetsFromPolygonToEthereumTreasury_20231018.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(0xCCAfBbbD68bb9B1A5F1C6ac948ED1944429F360a);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231018_AaveV3_Pol_TransferAssetsFromPolygonToEthereumTreasury/TransferAssetsFromPolygonToEthereumTreasury.md'
      )
    );
  }
}
