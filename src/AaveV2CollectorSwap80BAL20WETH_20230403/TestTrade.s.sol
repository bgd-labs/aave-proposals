// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Script} from 'forge-std/Script.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import {IMilkman} from './interfaces/IMilkman.sol';

contract TestTrade is Script {
    address public constant BAL80WETH20 = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
    address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
    address public constant PRICE_CHECKER = 0xBeA6AAC5bDCe0206A9f909d80a467C93A7D6Da7c;

    function run() external {
        vm.startBroadcast();

        // IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).approve(MILKMAN, 17e16);

        IMilkman(MILKMAN).requestSwapExactTokensForTokens(
            17e16,
            IERC20(AaveV2EthereumAssets.WETH_UNDERLYING),
            IERC20(AaveV2EthereumAssets.BAL_UNDERLYING),
            0x2fb7d6bEb9AD75c1ffD392681cC68171B8551107,
            PRICE_CHECKER,
            abi.encode(2000, bytes('')) // 1.5% slippage
        );

        vm.stopBroadcast();
    }

    // function run() external {
    //     vm.startBroadcast();

    //     IMilkman(0xE3c71D4F072e27D6c5522162DFD77A1fb959530A).cancelSwap(
    //         17e16,
    //         IERC20(AaveV2EthereumAssets.WETH_UNDERLYING),
    //         IERC20(AaveV2EthereumAssets.BAL_UNDERLYING),
    //         0x2fb7d6bEb9AD75c1ffD392681cC68171B8551107,
    //         PRICE_CHECKER,
    //         abi.encode(2000, bytes('')) // 1.5% slippage
    //     );
    //     vm.stopBroadcast();
    // }
}
