// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from 'forge-std/Script.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IMilkman} from './interfaces/IMilkman.sol';

// forge script src/AaveV2_Eth_ServiceProviders_20231907/TestTrade.s.sol:TestTrade --rpc-url mainnet --broadcast --private-key ${PRIVATE_KEY} --slow -vvvv
/*
 * We used this script to conduct a test transaction for a small amount in order to validate the swap.
 * This file can be ignored and deleted or used for a test transaction.
 */
contract TestTrade is Script {
  using SafeERC20 for IERC20;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant CHAINLINK_PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  function run() external {
    vm.startBroadcast();

    uint256 amount = 96797e16;

    IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).forceApprove(MILKMAN, amount);

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      amount,
      IERC20(AaveV2EthereumAssets.DAI_UNDERLYING),
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING),
      address(0), // Replace with caller's address
      CHAINLINK_PRICE_CHECKER,
      _getEncodedData(AaveV3EthereumAssets.DAI_ORACLE, AaveV3EthereumAssets.USDC_ORACLE)
    );

    /* The following commented code cancels the swap above */

    // IMilkman(address(0)).cancelSwap( // Update address with instance for trade
    //   amount,
    //   IERC20(AaveV2EthereumAssets.DAI_UNDERLYING),
    //   IERC20(AaveV2EthereumAssets.USDC_UNDERLYING),
    //   address(0), // Replace with address passed in `requestSwapExactTokensForTokens`
    //   CHAINLINK_PRICE_CHECKER,
    //   _getEncodedData(AaveV3EthereumAssets.DAI_ORACLE, AaveV3EthereumAssets.USDC_ORACLE)
    // );

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

    return abi.encode(1000, data); // 1000 = 10% slippage because of 1,000 amount and need to account for gas
  }
}
