// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from 'forge-std/Script.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import {IMilkman} from './interfaces/IMilkman.sol';

// forge script src/AaveV2_Eth_ServiceProviders_20231907/TestTrade.s.sol:TestTrade --rpc-url mainnet --broadcast --private-key ${PRIVATE_KEY} --slow -vvvv
/*
 * We used this script to conduct a test transaction for a small amount in order to validate the swap.
 * This file can be ignored and deleted or used for a test transaction.
 * 
 * Test TX: 
 */
contract TestTrade is Script {
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant CHAINLINK_PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  function run() external {
    vm.startBroadcast();

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(MILKMAN, 100e6);

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      100e6,
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING),
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN),
      0x2fb7d6bEb9AD75c1ffD392681cC68171B8551107, // Replace with caller's address
      CHAINLINK_PRICE_CHECKER,
      _getEncodedData(AaveV2EthereumAssets.USDC_ORACLE, AaveV2EthereumAssets.USDC_ORACLE)
    );

    vm.stopBroadcast();
  }

  function _getEncodedData(
    address oracleOne,
    address oracleTwo
  ) internal pure returns (bytes memory) {
    bytes memory data;
    address[] memory paths = new address[](2);
    paths[0] = oracleOne;
    paths[1] = oracleTwo;

    bool[] memory reverses = new bool[](2);
    reverses[1] = true;

    data = abi.encode(paths, reverses);

    return abi.encode(3500, data); // 3500 = 35% slippage just cause it's a super small amount
  }
}
