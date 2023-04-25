// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title WBTC Price Feed update
 * @author BGD Labs
 * @notice Change WBTC price feed on the Aave Ethereum v2 pool.
 * Governance Forum Post: https://governance.aave.com/t/bgd-generalised-price-sync-adapters/11416
 */
contract AaveV2PriceFeedsUpdate_20230425_Payload {
  // WBTC / BTC / ETH price adapter
  address public constant WBTC_ADAPTER = address(0);

  function execute() external {
    address[] memory assets = new address[](1);
    address[] memory sources = new address[](1);

    assets[0] = AaveV2EthereumAssets.WBTC_UNDERLYING;
    sources[0] = WBTC_ADAPTER;

    AaveV2Ethereum.ORACLE.setAssetSources(assets, sources);
  }
}
