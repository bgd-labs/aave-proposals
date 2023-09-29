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
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @dev (1) Swap aEthDAI to GHO; (2) Create stream to Tokenlogic
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x05636d75aae6e99be9c79a6337603f69213d34c3cf0b518842aa994f2ec790bf
 * - Discussion: https://governance.aave.com/t/arfc-tokenlogic-6-month-service-provider-proposal/14793 
 */
contract TokenLogicFunding_20230919 is IProposalGenericExecutor {

  struct Asset {
    address underlying;
    address aToken;
    address oracle;
    uint256 amount;
  }
  
  function execute() external {
    address MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
    address PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
    AaveSwapper SWAPPER = AaveSwapper(AaveMisc.AAVE_SWAPPER_ETHEREUM);

    Asset memory DAI = Asset({
      underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
      aToken: AaveV3EthereumAssets.DAI_A_TOKEN,
      oracle: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
      amount: 350_000 * 1e18
    });

    Asset memory GHO = Asset({
      underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
      aToken: address(0), // not used
      oracle: 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC,
      amount: 350_000 * 1e18
    });

    /// 1. withdraw DAI & swap to GHO

    AaveV3Ethereum.COLLECTOR.transfer(DAI.aToken, address(this), DAI.amount);

    uint256 SWAPPER_DAI_BALANCE = 
      AaveV3Ethereum.POOL.withdraw(DAI.underlying, DAI.amount, AaveMisc.AAVE_SWAPPER_ETHEREUM);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      DAI.underlying,
      GHO.underlying,
      DAI.oracle,
      GHO.oracle,
      address(AaveV3Ethereum.COLLECTOR),
      SWAPPER_DAI_BALANCE,
      50
    );

    /// 2. create GHO stream
    address TOKENLOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
    uint256 STREAM_DURATION = 180 days;
    uint256 ACTUAL_STREAM_AMOUNT = (GHO.amount / STREAM_DURATION) * STREAM_DURATION;

    AaveV3Ethereum.COLLECTOR.createStream(
      TOKENLOGIC, 
      ACTUAL_STREAM_AMOUNT, 
      GHO.underlying, 
      block.timestamp, 
      block.timestamp + STREAM_DURATION
    );
  }
}