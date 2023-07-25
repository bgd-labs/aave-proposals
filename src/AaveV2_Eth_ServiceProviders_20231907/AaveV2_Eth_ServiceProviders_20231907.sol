// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

import {IMilkman} from './interfaces/IMilkman.sol';

/**
 * @title Acquire more aUSDC to pay service providers
 * @author Llama
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083
 * - Discussion: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
 */
contract AaveV2_Eth_ServiceProviders_20231907 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant CHAINLINK_PRICE_CHECKER = 0x4D2c3773E69cB69963bFd376e538eC754409ACFa;

  uint256 public constant AMOUNT_USDT = 974_000e6;
  uint256 public constant AMOUNT_DAI = 974_000e18;

  function execute() external {
    uint256 balance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.USDC_UNDERLYING, address(this), balance);

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).safeApprove(address(AaveV2Ethereum.POOL), balance);
    AaveV2Ethereum.POOL.deposit(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      balance,
      address(AaveV2Ethereum.COLLECTOR),
      0
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      address(this),
      AMOUNT_USDT
    );
    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.DAI_A_TOKEN, address(this), AMOUNT_DAI);

    IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).safeApprove(MILKMAN, AMOUNT_USDT);
    IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).safeApprove(MILKMAN, AMOUNT_DAI);

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      AMOUNT_USDT,
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN),
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN),
      address(AaveV2Ethereum.COLLECTOR),
      CHAINLINK_PRICE_CHECKER,
      _getEncodedData(AaveV2EthereumAssets.USDT_ORACLE, AaveV2EthereumAssets.USDC_ORACLE)
    );

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      AMOUNT_DAI,
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN),
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN),
      address(AaveV2Ethereum.COLLECTOR),
      CHAINLINK_PRICE_CHECKER,
      _getEncodedData(AaveV2EthereumAssets.DAI_ORACLE, AaveV2EthereumAssets.USDC_ORACLE)
    );
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

    return abi.encode(100, data); // 100 = 1% slippage
  }
}
