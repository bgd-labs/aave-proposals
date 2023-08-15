// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Avalanche_StataTokenOperationalUpdate_20230815} from './AaveV3_Avalanche_StataTokenOperationalUpdate_20230815.sol';

/**
 * @dev Test for AaveV3_Avalanche_StataTokenOperationalUpdate_20230815
 * command: make test-contract filter=AaveV3_Avalanche_StataTokenOperationalUpdate_20230815
 */
contract AaveV3_Avalanche_StataTokenOperationalUpdate_20230815_Test is ProtocolV3TestBase {
  AaveV3_Avalanche_StataTokenOperationalUpdate_20230815 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 33943199);
    proposal = new AaveV3_Avalanche_StataTokenOperationalUpdate_20230815();
  }

  function testProposalExecution() public {
    GovHelpers.executePayload(
      vm,
      address(proposal),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );
  }
}
