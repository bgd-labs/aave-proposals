// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IPriceOracleSentinel} from 'aave-v3-core/contracts/interfaces/IPriceOracleSentinel.sol';
import {AaveV3OptPriceOracleSentinel_20230511_Payload} from './AaveV3OptPriceOracleSentinel_20230511_Payload.sol';

contract AaveV3OptPriceOracleSentinel_20230511_PayloadTest is TestWithExecutor {
  address public constant CHAINLINK_SEQUENCER_FEED = 0x371EAD81c9102C9BF4874A9075FFFf170F2Ee389;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 97421252);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3OptPriceOracleSentinel_20230511_Payload payload = new AaveV3OptPriceOracleSentinel_20230511_Payload();
    IPriceOracleSentinel priceOracleSentinel = IPriceOracleSentinel(payload.PRICE_ORACLE_SENTINEL());

    // execute payload:
    _executePayload(address(payload));

    // Verify payload:
    // check if addresses provider has been configured correctly
    assertEq(
      address(priceOracleSentinel.ADDRESSES_PROVIDER()),
      address(AaveV3Optimism.POOL_ADDRESSES_PROVIDER)
    );
    // check the chainlink sequencer feed has been configured correctly
    assertEq(
      address(priceOracleSentinel.getSequencerOracle()),
      CHAINLINK_SEQUENCER_FEED
    );
    // check the priceOracleSentinel has been set correctly on the addresses provider
    assertEq(
      address(priceOracleSentinel),
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel()
    );
    // check the grace period has been configured correctly
    assertEq(
      priceOracleSentinel.getGracePeriod(),
      3600
    );
  }
}
