// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @title GHO Funding
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb094cdc806d407d0cf4ea00e595ae95b8c145f77b77cce165c463326cc757639
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-gho-funding/14887/10
 */
contract AaveV3_Ethereum_GHOFunding_20230926 is IProposalGenericExecutor {

  struct Asset {
    address underlying;
    address aToken;
    address oracle;
    uint256 amount;
  }

  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant GHO_ORACLE = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC; 

  function execute() external {
    // DAI v2
    Asset memory DAIv2 = Asset({
      underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
      aToken: AaveV2EthereumAssets.DAI_A_TOKEN,
      oracle: AaveV3EthereumAssets.DAI_ORACLE,
      amount: IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(COLLECTOR)
    });

    // DAI v3
    Asset memory DAIv3 = Asset({
      underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
      aToken: AaveV3EthereumAssets.DAI_A_TOKEN,
      oracle: AaveV3EthereumAssets.DAI_ORACLE,
      amount: 370_000 * 1e18
    });

    // USDT v2
    Asset memory USDTv2 = Asset({
      underlying: AaveV2EthereumAssets.USDT_UNDERLYING,
      aToken: AaveV2EthereumAssets.USDT_A_TOKEN,
      oracle: 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D,
      amount: 370_000 * 1e6
    });

    // BUSD
    Asset memory BUSD = Asset({
      underlying: AaveV2EthereumAssets.BUSD_UNDERLYING,
      aToken: address(0), // not used
      oracle: 0x833D8Eb16D306ed1FbB5D7A2E019e106B960965A,
      amount: IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(COLLECTOR)
    });
    
    // TUSD v2
    Asset memory TUSD = Asset({
      underlying: AaveV2EthereumAssets.TUSD_UNDERLYING,
      aToken: address(0), // not used
      oracle: 0xec746eCF986E2927Abd291a2A1716c940100f8Ba,
      amount: IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(COLLECTOR)
    });


    ////// DAI v2 & v3 swap //////
    AaveV3Ethereum.COLLECTOR.transfer(DAIv2.aToken, address(this), DAIv2.amount);
    AaveV3Ethereum.COLLECTOR.transfer(DAIv3.aToken, address(this), DAIv3.amount);
    uint256 daiAmount = 
      AaveV2Ethereum.POOL.withdraw(DAIv2.underlying, type(uint256).max, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    daiAmount += 
      AaveV3Ethereum.POOL.withdraw(DAIv3.underlying, type(uint256).max, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapAsset(DAIv2, daiAmount);

    ////// BUSD swap //////
    AaveV3Ethereum.COLLECTOR.transfer(BUSD.underlying, AaveMisc.AAVE_SWAPPER_ETHEREUM, BUSD.amount);
    swapAsset(BUSD, BUSD.amount);

    ////// TUSD swap //////
    AaveV3Ethereum.COLLECTOR.transfer(TUSD.underlying, AaveMisc.AAVE_SWAPPER_ETHEREUM, TUSD.amount);
    swapAsset(TUSD, TUSD.amount);

    ////// USDT v2 swap //////
    AaveV3Ethereum.COLLECTOR.transfer(USDTv2.aToken, address(this), USDTv2.amount);
    uint256 usdtAmount =  
      AaveV2Ethereum.POOL.withdraw(USDTv2.underlying, type(uint256).max, AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapAsset(USDTv2, usdtAmount);
  }

  function swapAsset(Asset memory asset, uint256 amount) internal {
    AaveSwapper swapper = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);
    swapper.swap(
      MILKMAN,
      PRICE_CHECKER,
      asset.underlying,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      asset.oracle,
      GHO_ORACLE,
      COLLECTOR,
      amount,
      50
    );
  }
}
