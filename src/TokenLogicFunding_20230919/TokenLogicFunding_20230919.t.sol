// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {TokenLogicFunding_20230919} from './TokenLogicFunding_20230919.sol';

contract TokenLogicFunding_20230919_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18166945);
  }

  function testpayload() public {

    address TOKENLOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;

    TokenLogicFunding_20230919 payload = new TokenLogicFunding_20230919();

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    /// check if can withdraw from stream
    vm.warp(block.timestamp + 181 days);
    vm.prank(TOKENLOGIC);
    
  }
}
