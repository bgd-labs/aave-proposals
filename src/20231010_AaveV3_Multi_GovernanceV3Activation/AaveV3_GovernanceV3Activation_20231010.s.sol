// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231010_AaveV3_Multi_GovernanceV3Activation/AaveV3_GovernanceV3Activation_20231010.s.sol:CreateLongProposal chain=mainnet
 */
contract CreateLongProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x6195a956dC026A949dE552F04a5803d3aa1fC408); // https://etherscan.io/address/0x6195a956dc026a949de552f04a5803d3aa1fc408

    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231010_AaveV3_Multi_GovernanceV3Activation/GovernanceV3Activation.md'
      ),
      AaveGovernanceV2.LONG_EXECUTOR
    );
  }
}

Avalanche: https://snowtrace.io/address/0xb58e840e1356ed9b7f89d11a03d4cef24f56a1ea
Metis: https://andromeda-explorer.metis.io/address/0x230E0321Cf38F09e247e50Afc7801EA2351fe56F/
Base: https://basescan.org/address/0x4959bad86d851378c6bccf07cb8240d55a11c5ac

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231010_AaveV3_Multi_GovernanceV3Activation/AaveV3_GovernanceV3Activation_20231010.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](6);
    payloads[0] = GovHelpers.buildMainnet(0xa59262276dB8F997948fdc4a10cBc1448A375636); // https://etherscan.io/address/0xa59262276db8f997948fdc4a10cbc1448a375636
    payloads[1] = GovHelpers.buildOptimism(0x7fc3FCb14eF04A48Bb0c12f0c39CD74C249c37d8); // https://optimistic.etherscan.io/address/0x7fc3fcb14ef04a48bb0c12f0c39cd74c249c37d8
    payloads[2] = GovHelpers.buildArbitrum(0xFD858c8bC5ac5e10f01018bC78471bb0DC392247); // https://arbiscan.io/address/0xfd858c8bc5ac5e10f01018bc78471bb0dc392247
    payloads[3] = GovHelpers.buildPolygon(0x274a46Efd4364CcBA654Dc74Ddb793F9010B179c); // https://polygonscan.com/address/0x274a46efd4364ccba654dc74ddb793f9010b179c
    payloads[4] = GovHelpers.buildMetis(0x230E0321Cf38F09e247e50Afc7801EA2351fe56F); // https://andromeda-explorer.metis.io/address/0x230E0321Cf38F09e247e50Afc7801EA2351fe56F/
    payloads[5] = GovHelpers.buildBase(0x4959BAD86D851378C6BCcf07cB8240d55A11C5AC); // https://basescan.org/address/0x4959bad86d851378c6bccf07cb8240d55a11c5ac
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231010_AaveV3_Multi_GovernanceV3Activation/GovernanceV3Activation.md'
      )
    );
  }
}
