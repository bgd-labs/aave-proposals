// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

library TokenAddresses {
  struct TokenToSwap {
    address token;
    address oracle;
    uint256 slippage;
  }

  struct TokenToWithdraw {
    address underlying;
    address aToken;
  }

  function getTokensToWithdrawCollector() public pure returns (address[] memory) {
    address[] memory tokens = new address[](7);
    tokens[0] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    tokens[1] = AaveV2EthereumAssets.YFI_UNDERLYING;
    tokens[2] = AaveV2EthereumAssets.UNI_UNDERLYING;
    tokens[3] = AaveV2EthereumAssets.MKR_UNDERLYING;
    tokens[4] = AaveV2EthereumAssets.DAI_UNDERLYING;
    tokens[5] = AaveV2EthereumAssets.USDT_UNDERLYING;
    tokens[6] = AaveV2EthereumAssets.TUSD_UNDERLYING;

    return tokens;
  }

  function getTokensToWithdraw() public pure returns (TokenToWithdraw[] memory) {
    TokenToWithdraw[] memory tokens = new TokenToWithdraw[](9);
    tokens[0] = TokenToWithdraw(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      AaveV2EthereumAssets.MKR_A_TOKEN
    );
    tokens[1] = TokenToWithdraw(
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      AaveV2EthereumAssets.GUSD_A_TOKEN
    );
    tokens[2] = TokenToWithdraw(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_A_TOKEN
    );
    tokens[3] = TokenToWithdraw(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.LUSD_A_TOKEN
    );
    tokens[4] = TokenToWithdraw(
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.UST_A_TOKEN
    );
    tokens[5] = TokenToWithdraw(
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      AaveV2EthereumAssets.sUSD_A_TOKEN
    );
    tokens[6] = TokenToWithdraw(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      AaveV2EthereumAssets.YFI_A_TOKEN
    );
    tokens[7] = TokenToWithdraw(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      AaveV2EthereumAssets.UNI_A_TOKEN
    );
    tokens[8] = TokenToWithdraw(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_A_TOKEN
    );

    return tokens;
  }

  function getTokensToSwap() public pure returns (TokenToSwap[] memory) {
    TokenToSwap[] memory tokens = new TokenToSwap[](11);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      AaveV2EthereumAssets.sUSD_ORACLE,
      300
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.UST_ORACLE,
      300
    );
    tokens[2] = TokenToSwap(
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      AaveV2EthereumAssets.GUSD_ORACLE,
      300
    );
    tokens[3] = TokenToSwap(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      AaveV2EthereumAssets.YFI_ORACLE,
      500
    );
    tokens[4] = TokenToSwap(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_ORACLE,
      100
    );
    tokens[5] = TokenToSwap(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      AaveV2EthereumAssets.UNI_ORACLE,
      500
    );
    tokens[6] = TokenToSwap(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      AaveV2EthereumAssets.MKR_ORACLE,
      300
    );
    tokens[7] = TokenToSwap(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_ORACLE,
      300
    );
    tokens[8] = TokenToSwap(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_ORACLE,
      500
    );
    tokens[9] = TokenToSwap(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.LUSD_ORACLE,
      500
    );
    tokens[10] = TokenToSwap(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_ORACLE,
      300
    );

    return tokens;
  }
}
