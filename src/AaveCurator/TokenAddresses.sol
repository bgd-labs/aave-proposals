// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

library TokenAddresses {
  address public constant ARC_aUSDC = 0xd35f648C3C7f17cd1Ba92e5eac991E3EfcD4566d;
  address public constant RWA_aUSDC = 0x9Bc94a6A0D99fe559fA4DC5354ce3B96B210c210;

  struct TokenToSwap {
    address token;
    address oracle;
    bool isEthFeed;
    uint256 amount;
    uint256 slippage;
  }

  function getTokensTotalBalance() public pure returns (TokenToSwap[] memory) {
    TokenToSwap[] memory tokens = new TokenToSwap[](15);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.sUSD_A_TOKEN,
      AaveV2EthereumAssets.sUSD_ORACLE,
      true,
      0,
      100
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.UST_A_TOKEN,
      AaveV2EthereumAssets.UST_ORACLE,
      true,
      0,
      100
    );
    tokens[2] = TokenToSwap(RWA_aUSDC, AaveV2EthereumAssets.USDC_ORACLE, true, 0, 100);
    tokens[3] = TokenToSwap(
      AaveV2EthereumAssets.GUSD_A_TOKEN,
      AaveV2EthereumAssets.GUSD_ORACLE,
      true,
      0,
      100
    );
    tokens[4] = TokenToSwap(
      AaveV2EthereumAssets.MKR_A_TOKEN,
      AaveV2EthereumAssets.MKR_ORACLE,
      true,
      0,
      100
    );
    tokens[5] = TokenToSwap(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_ORACLE,
      true,
      0,
      100
    );
    tokens[6] = TokenToSwap(
      AaveV2EthereumAssets.BUSD_A_TOKEN,
      AaveV2EthereumAssets.BUSD_ORACLE,
      true,
      0,
      100
    );
    tokens[7] = TokenToSwap(
      AaveV2EthereumAssets.FRAX_A_TOKEN,
      AaveV2EthereumAssets.FRAX_ORACLE,
      true,
      0,
      100
    );
    tokens[8] = TokenToSwap(
      AaveV2EthereumAssets.YFI_A_TOKEN,
      AaveV2EthereumAssets.YFI_ORACLE,
      true,
      0,
      100
    );
    tokens[9] = TokenToSwap(
      AaveV2EthereumAssets.LUSD_A_TOKEN,
      AaveV2EthereumAssets.LUSD_ORACLE,
      true,
      0,
      100
    );
    tokens[10] = TokenToSwap(
      AaveV2EthereumAssets.UNI_A_TOKEN,
      AaveV2EthereumAssets.UNI_ORACLE,
      true,
      0,
      100
    );
    tokens[11] = TokenToSwap(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_ORACLE,
      true,
      0,
      100
    );
    tokens[12] = TokenToSwap(
      AaveV2EthereumAssets.TUSD_A_TOKEN,
      AaveV2EthereumAssets.TUSD_ORACLE,
      true,
      0,
      100
    );
    tokens[13] = TokenToSwap(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_ORACLE,
      true,
      0,
      100
    );
    tokens[14] = TokenToSwap(ARC_aUSDC, AaveV2EthereumAssets.USDC_ORACLE, true, 0, 100);

    return tokens;
  }

  function getTokensSpecificBalance() public pure returns (TokenToSwap[] memory) {
    TokenToSwap[] memory tokens = new TokenToSwap[](2);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      AaveV2EthereumAssets.USDT_ORACLE,
      true,
      974_000e6,
      100
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.DAI_A_TOKEN,
      AaveV2EthereumAssets.DAI_ORACLE,
      true,
      974_000e18,
      100
    );

    return tokens;
  }
}
