// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Opt_wstETH_CapsIncrease_20230908} from './AaveV3_Opt_wstETH_CapsIncrease_20230908.sol';
import {AaveV3_Arb_wstETH_CapsIncrease_20230908} from './AaveV3_Arb_wstETH_CapsIncrease_20230908.sol';
import {AaveV3_Pol_wstETH_CapsIncrease_20230908} from './AaveV3_Pol_wstETH_CapsIncrease_20230908.sol';

/**
 * @dev Deploy AaveV3_Opt_wstETH_CapsIncrease_20230908
 
 * command: make deploy-ledger contract=src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Multi_wstETH_CapsIncrease_20230908.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Opt_wstETH_CapsIncrease_20230908();
  }
}

/**
 * @dev Deploy AaveV3_Arb_wstETH_CapsIncrease_20230908

 * command: make deploy-ledger contract=src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Multi_wstETH_CapsIncrease_20230908.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arb_wstETH_CapsIncrease_20230908();
  }
}

/**
 * @dev Deploy AaveV3_Pol_wstETH_CapsIncrease_20230908
 * command: make deploy-ledger contract=src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Multi_wstETH_CapsIncrease_20230908.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3_Pol_wstETH_CapsIncrease_20230908();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Multi_wstETH_CapsIncrease_20230908.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildOptimism(0xf285E2D9c5CdAab11c167ffa70fa4055fbeAed96);
    payloads[1] = GovHelpers.buildArbitrum(0x83a67159a0ad5612178Bed9deB43C0F58E941932);
    payloads[2] = GovHelpers.buildPolygon(0xaf6568bD3923e2AD05a0d6e4206f601D08E0Cde2);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3_Multi_wstETH_CapsIncrease_20230908/wstETH_CapsIncrease.md'
      )
    );
  }
}
