// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

/**
 * @title AaveV3OptOPEmissionAdminPayload
 * @author Llama
 * @dev Setting new Emssion Admin for OP token in Aave V3 Optimism Liquidity Pool
 * Governance Forum Post: https://governance.aave.com/t/arfc-grant-op-emission-admin-for-optimism-v3-liquidity-pool-to-lido-dao/11905
 */
contract AaveV3OptOPEmissionAdminPayload is IProposalGenericExecutor {
  address public constant OP = 0x4200000000000000000000000000000000000042;
  address public constant NEW_EMISSION_ADMIN = 0x5033823F27c5f977707B58F0351adcD732C955Dd;

  function execute() external {
    IEmissionManager(AaveV3Optimism.EMISSION_MANAGER).setEmissionAdmin(OP, NEW_EMISSION_ADMIN);
  }
}
