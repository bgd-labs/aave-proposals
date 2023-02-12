// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV2SwapxSushiPriceFeedPayload} from '../../contracts/mainnet/AaveV2SwapxSushiPriceFeedPayload.sol';

contract AaveV2SwapxSushiPriceFeedPayloadTest is ProtocolV2TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16576684);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testSwapXSushiOracle() public {
    AaveV2SwapxSushiPriceFeedPayload payload = new AaveV2SwapxSushiPriceFeedPayload();

    _executePayload(address(payload));

    _validateAssetSourceOnOracle(
      AaveV2Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      0xF05D9B6C08757EAcb1fbec18e36A1B7566a13DEB
    );
  }
}
