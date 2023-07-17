// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

library TokenAddresses {
    function getTokens() public pure returns (address[1] memory) {
        return [
            AaveV3EthereumAssets.WETH_UNDERLYING
        ];
    }
}
