// SPDX-License-Identifier: MIT

/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/

pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @dev (1) Swap aEthUSDC & aEthUSDT to GHO; (2) Replace Aave Grants DAO’s (AGD) DAI allowance with a GHO allowance.
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x53728c0416a9063bf833f90c3b3169fa4387e66549d5eb2b7ed2747bfe7c23fc
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-replace-agd-s-dai-allowance-with-gho-allowance/14631
 */
contract AgdAllowanceModification_20230817 is IProposalGenericExecutor {

  struct Asset {
    address underlying;
    address aToken;
    address oracle;
    uint256 amount;
  }
  
  function execute() external {
    address agdMultisig = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
    address milkman = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
    address priceChecker = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

    Asset memory USDC = Asset({
      underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
      aToken: AaveV3EthereumAssets.USDC_A_TOKEN,
      oracle: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
      amount: 228_000 * 1e6
    });

    Asset memory USDT = Asset({
      underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
      aToken: AaveV3EthereumAssets.USDT_A_TOKEN,
      oracle: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
      amount: 150_000 * 1e6
    });

    Asset memory GHO = Asset({
      underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
      aToken: address(0), // not used
      oracle: 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC,
      amount: 388_000 * 1e18
    });

    AaveSwapper swapper = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);

    /// 1. swap USDC & USDT to GHO

    AaveV3Ethereum.COLLECTOR.transfer(USDC.aToken, address(this), USDC.amount);
    AaveV3Ethereum.COLLECTOR.transfer(USDT.aToken, address(this), USDT.amount);

    uint256 executorUsdcBalance = 
      AaveV3Ethereum.POOL.withdraw(USDC.underlying, USDC.amount, address(swapper));
    uint256 executorUsdtBalance = 
      AaveV3Ethereum.POOL.withdraw(USDT.underlying, USDT.amount, address(swapper));

    swapper.swap(
      milkman,
      priceChecker,
      USDC.underlying,
      GHO.underlying,
      USDC.oracle,
      GHO.oracle,
      address(AaveV3Ethereum.COLLECTOR),
      executorUsdcBalance,
      50
    );

    swapper.swap(
      milkman,
      priceChecker,
      USDT.underlying,
      GHO.underlying,
      USDT.oracle,
      GHO.oracle,
      address(AaveV3Ethereum.COLLECTOR),
      executorUsdtBalance,
      50
    );

    /// 2. remove aDAI allowance and add GHO allowance
    uint256 currentAllowance = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN)
      .allowance(address(AaveV3Ethereum.COLLECTOR), agdMultisig);
    AaveV3Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.DAI_A_TOKEN, agdMultisig, 0);
    AaveV3Ethereum.COLLECTOR.approve(GHO.underlying, agdMultisig, currentAllowance);
  }
}