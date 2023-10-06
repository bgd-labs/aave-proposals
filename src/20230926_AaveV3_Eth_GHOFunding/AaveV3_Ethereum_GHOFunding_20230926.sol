// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

interface aTokenV1 {
  function redeem(uint256 _amount) external;
}

/**
 * @title GHO Funding
 * @author TokenLogic
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-gho-funding/14887
 */
contract AaveV3_Ethereum_GHOFunding_20230926 is IProposalGenericExecutor {

  struct Asset {
    address underlying;
    address aToken;
    address oracle;
    uint256 amount;
  }

  function execute() external {
    // DAI v2
    Asset memory DAIv2 = Asset({
      underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
      aToken: AaveV2EthereumAssets.DAI_A_TOKEN,
      oracle: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
      amount: IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    });

    // BUSD v2
    Asset memory BUSDv2 = Asset({
      underlying: AaveV2EthereumAssets.BUSD_UNDERLYING,
      aToken: AaveV2EthereumAssets.BUSD_A_TOKEN,
      oracle: 0x833D8Eb16D306ed1FbB5D7A2E019e106B960965A,
      amount: IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    });

    // DAI v3
    Asset memory DAIv3 = Asset({
      underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
      aToken: AaveV3EthereumAssets.DAI_A_TOKEN,
      oracle: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
      amount: 400_000 * 1e18
    });

    // USDT v2
    Asset memory USDTv2 = Asset({
      underlying: AaveV2EthereumAssets.USDT_UNDERLYING,
      aToken: AaveV2EthereumAssets.USDT_A_TOKEN,
      oracle: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
      amount: 1_100_000 * 1e6
    });

    // USDT v3
    Asset memory USDTv3 = Asset({
      underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
      aToken: AaveV3EthereumAssets.USDT_A_TOKEN,
      oracle: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
      amount: 500_000 * 1e6
    });


    ////// DAI v2 & v3 swap //////
    AaveV3Ethereum.COLLECTOR.transfer(DAIv2.aToken, address(this), DAIv2.amount);
    AaveV3Ethereum.COLLECTOR.transfer(DAIv3.aToken, address(this), DAIv3.amount);
    uint256 swapperBalance = 
      AaveV2Ethereum.POOL.withdraw(DAIv2.underlying, DAIv2.amount, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapperBalance += 
      AaveV3Ethereum.POOL.withdraw(DAIv3.underlying, DAIv3.amount, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapAsset(DAIv2, swapperBalance);

    ////// BUSD v2 & v1 swap //////
    // transfer max busd to payload
    swapperBalance = IERC20(BUSDv2.underlying).balanceOf(address(AaveV3Ethereum.COLLECTOR));
    AaveV3Ethereum.COLLECTOR.transfer(BUSDv2.underlying, address (this), swapperBalance);
    // transfer specific amount of busdv2 to payload
    AaveV3Ethereum.COLLECTOR.transfer(BUSDv2.aToken, address(this), BUSDv2.amount);
    swapperBalance += AaveV2Ethereum.POOL.withdraw(BUSDv2.underlying, BUSDv2.amount, address(this));
    
    SafeERC20.safeTransfer(IERC20(BUSDv2.underlying), AaveMisc.AAVE_SWAPPER_ETHEREUM, swapperBalance);
    swapAsset(BUSDv2, swapperBalance);

    ////// USDT v2 & v3 swap //////
    AaveV3Ethereum.COLLECTOR.transfer(USDTv2.aToken, address(this), USDTv2.amount);
    AaveV3Ethereum.COLLECTOR.transfer(USDTv3.aToken, address(this), USDTv3.amount);
    swapperBalance = 
      AaveV2Ethereum.POOL.withdraw(USDTv2.underlying, USDTv2.amount, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapperBalance += 
      AaveV3Ethereum.POOL.withdraw(USDTv3.underlying, USDTv3.amount, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapAsset(USDTv2, swapperBalance);
  }

  function swapAsset(Asset memory asset, uint256 amount) internal {
    address milkman = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
    address priceChecker = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
    address ghoOracle = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC; 
    AaveSwapper swapper = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapper.swap(
      milkman,
      priceChecker,
      asset.underlying,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      asset.oracle,
      ghoOracle,
      address(AaveV3Ethereum.COLLECTOR),
      amount,
      50
    );
  }
}
