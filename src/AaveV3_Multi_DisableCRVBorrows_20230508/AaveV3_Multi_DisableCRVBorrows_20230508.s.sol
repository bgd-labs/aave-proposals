// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Eth_DisableCRVBorrows_20230508} from './AaveV3_Eth_DisableCRVBorrows_20230508.sol';
import {AaveV3_Pol_DisableCRVBorrows_20230508} from './AaveV3_Pol_DisableCRVBorrows_20230508.sol';

/**
 * @dev Deploy AaveV3_Eth_DisableCRVBorrows_20230508
 * command: make deploy-pk contract=src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Multi_DisableCRVBorrows_20230508.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Eth_DisableCRVBorrows_20230508();
  }
}

/**
 * @dev Deploy AaveV3_Pol_DisableCRVBorrows_20230508
 * command: make deploy-pk contract=src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Multi_DisableCRVBorrows_20230508.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Pol_DisableCRVBorrows_20230508();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-pk contract=src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Multi_DisableCRVBorrows_20230508.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(address(0x10bDbDEB8D3Ff6273261dD7E9B90465000325DcB));
    payloads[1] = GovHelpers.buildPolygon(address(0xFa6481b09c273d17701fb90427D6658a028EdC18));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Multi_DisableCRVBorrows_20230508/DisableCRVBorrows.md'));
  }
}