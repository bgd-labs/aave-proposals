// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IPoolConfigurator} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal changes Lusd supply and borrow caps on Aave V3 Ethereum
 * @author @yonikesel - ChaosLabs
 * - Snapshot: Direct-to-AIP process
 * - Discussion: https://governance.aave.com/t/arfc-supply-and-borrow-caps-update-lusd-v3-ethereum/12289
 */

contract AaveV3EthLusdCapsPayload is IProposalGenericExecutor {
  uint256 public constant LUSD_SUPPLY_CAP = 6_000_000;
  uint256 public constant LUSD_BORROW_CAP = 2_400_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Ethereum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(AaveV3EthereumAssets.LUSD_UNDERLYING, LUSD_SUPPLY_CAP);
    configurator.setBorrowCap(AaveV3EthereumAssets.LUSD_UNDERLYING, LUSD_BORROW_CAP);
  }
}
