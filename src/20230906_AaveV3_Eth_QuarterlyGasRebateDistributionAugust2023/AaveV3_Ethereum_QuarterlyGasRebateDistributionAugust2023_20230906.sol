// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {Address} from 'solidity-utils/contracts/oz-common/Address.sol';

interface IWETH {
  function withdraw(uint wad) external;
}

/**
 * @title Quarterly Gas Rebate Distribution August 2023
 * @author Marc Zeller (@marczeller) - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xd41eebb9d9150f1d4ec106e8117809b78a4841641a18cd0ad47b5d31f6b6bf86
 * - Discussion: https://governance.aave.com/t/arfc-quarterly-gas-rebate-distribution-august-2023/14680
 */
contract AaveV3_Ethereum_QuarterlyGasRebateDistributionAugust2023_20230906 is
  IProposalGenericExecutor
{
  using Address for address payable;

  address public constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

  address public constant ACI = 0x329c54289Ff5D6B7b7daE13592C6B1EDA1543eD4;
  address public constant HKUST = 0xE4594A66d9507fFc0d4335CC240BD61C1173E666;
  address public constant TOKEN_LOGIC = 0x2cc1ADE245020FC5AAE66Ad443e1F66e01c54Df1;
  address public constant MICHIGAN = 0x13BDaE8c5F0fC40231F0E6A4ad70196F59138548;
  address public constant LBS = 0xB83b3e9C8E3393889Afb272D354A7a3Bd1Fbcf5C;
  address public constant WINTERMUTE = 0xB933AEe47C438f22DE0747D57fc239FE37878Dd1;
  address public constant KEYROCK = 0x1855f41B8A86e701E33199DE7C25d3e3830698ba;
  address public constant STABLELAB = 0xea172676E4105e92Cc52DBf45fD93b274eC96676;

  uint256 public constant ACI_AMOUNT = 1.35e18;
  uint256 public constant HKUST_AMOUNT = 0.07e18;
  uint256 public constant TOKEN_LOGIC_AMOUNT = 0.5e18;
  uint256 public constant MICHIGAN_AMOUNT = 0.11e18;
  uint256 public constant LBS_AMOUNT = 0.18e18;
  uint256 public constant WINTERMUTE_AMOUNT = 0.15e18;
  uint256 public constant KEYROCK_AMOUNT = 0.14e18;
  uint256 public constant STABLELAB_AMOUNT = 0.20e18;

  // total amount of WETH to withdraw + buffer
  uint256 public constant TOTAL_AMOUNT = 2.7e18;

  function execute() external {
    // withdraw WETH to short_executor
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      address(this),
      TOTAL_AMOUNT
    );

    // convert WETH to ETH
    IWETH(WETH).withdraw(TOTAL_AMOUNT);

    // transfer ETH to delegates
    payable(ACI).sendValue(ACI_AMOUNT);
    payable(HKUST).sendValue(HKUST_AMOUNT);
    payable(TOKEN_LOGIC).sendValue(TOKEN_LOGIC_AMOUNT);
    payable(MICHIGAN).sendValue(MICHIGAN_AMOUNT);
    payable(LBS).sendValue(LBS_AMOUNT);
    payable(WINTERMUTE).sendValue(WINTERMUTE_AMOUNT);
    payable(KEYROCK).sendValue(KEYROCK_AMOUNT);
    payable(STABLELAB).sendValue(STABLELAB_AMOUNT);
  }
}
