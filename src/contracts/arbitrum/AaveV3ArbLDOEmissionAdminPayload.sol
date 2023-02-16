// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/rewards/interfaces/IEmissionManager.sol';

/**
 * @title AaveV3ArbLDOEmissionAdminPayload
 * @author Llama
 * @dev Setting new Emssion Admin for LDO token in Aave V3 Arbitrum Liquidity Pool
 * Governance Forum Post: https://governance.aave.com/t/arfc-ldo-emission-admin-for-ethereum-arbitrum-and-optimism-v3-liquidity-pools/11478
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc28c45bf26a5ada3d891a5dbed7f76d1ff0444b9bc06d191a6ada99a658abe28
 */
contract AaveV3ArbLDOEmissionAdminPayload is IProposalGenericExecutor {
  address public constant LDO = 0x13Ad51ed4F1B7e9Dc168d8a00cB3f4dDD85EfA60;
  address public constant NEW_EMISSION_ADMIN = 0x8C2b8595eA1b627427EFE4f29A64b145DF439d16;

  function execute() external {
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(LDO, NEW_EMISSION_ADMIN);
  }
}
