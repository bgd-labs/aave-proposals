// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {IAaveOracle} from 'aave-address-book/AaveV2.sol';
import {AaveV2EthUnifyFallbackOracles20230507} from './AaveV2EthUnifyFallbackOracles20230507.sol';

contract AaveV2EthUnifyFallbackOracles20230507_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17627699);
  }

  function testProposalExecution() public {
    AaveV2EthUnifyFallbackOracles20230507 proposal = new AaveV2EthUnifyFallbackOracles20230507();

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    assertEq(AaveV2Ethereum.ORACLE.getFallbackOracle(), address(0));
    assertEq(AaveV2EthereumAMM.ORACLE.getFallbackOracle(), address(0));
    assertEq(IAaveOracle(proposal.AAVE_V1_ORACLE()).getFallbackOracle(), address(0));
  }
}
