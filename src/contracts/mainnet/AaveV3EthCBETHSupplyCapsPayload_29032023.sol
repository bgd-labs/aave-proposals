// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal changes cbETH supply cap on Aave V3 Ethereum
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP process
 * - Discussion: Discussion: https://governance.aave.com/t/arfc-increase-cbeth-supply-cap-03-26/12480
 */

contract AaveV3EthCBETHSupplyCapsPayload_29032023 is IProposalGenericExecutor {
  address public constant CBETH = AaveV3EthereumAssets.cbETH_UNDERLYING;

  uint256 public constant CBETH_SUPPLY_CAP = 60_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Ethereum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(CBETH, CBETH_SUPPLY_CAP);
  }
}
