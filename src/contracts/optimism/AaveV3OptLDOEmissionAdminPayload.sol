// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

/**
 * @title AaveV3OptimismLDOEmissionAdminPayload
 * @author Llama
 * @dev Setting new Emssion Admin for LDO token in Aave V3 Optimism Liquidity Pool
 * Governance Forum Post: https://governance.aave.com/t/arfc-ldo-emission-admin-for-ethereum-arbitrum-and-optimism-v3-liquidity-pools/11478
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc28c45bf26a5ada3d891a5dbed7f76d1ff0444b9bc06d191a6ada99a658abe28
 */
contract AaveV3OptLDOEmissionAdminPayload is IProposalGenericExecutor {
  address public constant LDO = 0xFdb794692724153d1488CcdBE0C56c252596735F;
  address public constant NEW_EMISSION_ADMIN = 0x5033823F27c5f977707B58F0351adcD732C955Dd;

  function execute() public {
    IEmissionManager(AaveV3Optimism.EMISSION_MANAGER).setEmissionAdmin(LDO, NEW_EMISSION_ADMIN);
  }
}
