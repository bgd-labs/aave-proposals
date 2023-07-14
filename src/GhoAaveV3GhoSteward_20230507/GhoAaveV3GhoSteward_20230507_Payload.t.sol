// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;
import 'forge-std/Test.sol';

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {GhoAaveV3GhoSteward_20230507_Payload} from './GhoAaveV3GhoSteward_20230507_Payload.sol';
import {IGhoSteward} from 'gho-core/contracts/misc/interfaces/IGhoSteward.sol';
import {IPoolDataProvider} from 'aave-v3-core/contracts/interfaces/IPoolDataProvider.sol';

import {GhoInterestRateStrategy} from 'gho-core/contracts/facilitators/aave/interestStrategy/GhoInterestRateStrategy.sol';
import {IGhoToken} from 'gho-core/contracts/gho/interfaces/IGhoToken.sol';

contract GhoAaveV3GhoSteward_20230507_Payload_Test is ProtocolV3TestBase {
  GhoAaveV3GhoSteward_20230507_Payload public proposalPayload;

  function setUp() public {
    vm.createSelectFork('https://rpc.tenderly.co/fork/4aa4b542-16b5-4fb7-8f75-fc1a0e2e3848');
    proposalPayload = new GhoAaveV3GhoSteward_20230507_Payload();
  }

  function testGhoStewardRoles() public {
    bool beforeGhoStewardAdmin = AaveV3Ethereum.ACL_MANAGER.isPoolAdmin(
      proposalPayload.GHO_STEWARD()
    );
    assertFalse(beforeGhoStewardAdmin);

    IGhoToken iGhoToken = IGhoToken(proposalPayload.GHO_TOKEN());

    bool beforeHasBucketManagerRole = iGhoToken.hasRole(
      iGhoToken.BUCKET_MANAGER_ROLE(),
      proposalPayload.GHO_STEWARD()
    );

    assertFalse(beforeHasBucketManagerRole);

    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    bool afterGhoStewardAdmin = AaveV3Ethereum.ACL_MANAGER.isPoolAdmin(
      proposalPayload.GHO_STEWARD()
    );
    assertTrue(afterGhoStewardAdmin);

    bool afterHasBucketManagerRole = iGhoToken.hasRole(
      iGhoToken.BUCKET_MANAGER_ROLE(),
      proposalPayload.GHO_STEWARD()
    );

    assertTrue(afterHasBucketManagerRole);
  }

  function testUpdateBorrowRates() public {
    vm.startPrank(proposalPayload.RISK_COUNCIL());
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    IPoolDataProvider iPoolDataProvider = IPoolDataProvider(
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER
    );

    IGhoSteward ghoSteward = IGhoSteward(proposalPayload.GHO_STEWARD());

    address oldInterestStrategy = iPoolDataProvider.getInterestRateStrategyAddress(
      proposalPayload.GHO_TOKEN()
    );

    uint256 oldBorrowRate = GhoInterestRateStrategy(oldInterestStrategy)
      .getBaseVariableBorrowRate();

    uint256 newBorrowRate = oldBorrowRate + 15;

    ghoSteward.updateBorrowRate(newBorrowRate);

    address newInterestStrategy = iPoolDataProvider.getInterestRateStrategyAddress(
      proposalPayload.GHO_TOKEN()
    );
    assertEq(
      GhoInterestRateStrategy(newInterestStrategy).getBaseVariableBorrowRate(),
      newBorrowRate
    );
    vm.stopPrank();
  }

  function testUpdateBorrowRatesWhenNotRiskCouncil() public {
    vm.startPrank(address(0));
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);
    IGhoSteward ghoSteward = IGhoSteward(proposalPayload.GHO_STEWARD());
    vm.expectRevert('INVALID_CALLER');

    ghoSteward.updateBorrowRate(1);
    vm.stopPrank();
  }

  function testUpdateBucketCapacity() public {
    vm.startPrank(proposalPayload.RISK_COUNCIL());

    IPoolDataProvider iPoolDataProvider = IPoolDataProvider(
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER
    );

    (address ghoAToken, , ) = iPoolDataProvider.getReserveTokensAddresses(
      proposalPayload.GHO_TOKEN()
    );

    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    IGhoToken iGhoToken = IGhoToken(proposalPayload.GHO_TOKEN());
    IGhoSteward ghoSteward = IGhoSteward(proposalPayload.GHO_STEWARD());

    (uint256 oldBucketCapacity, ) = iGhoToken.getFacilitatorBucket(ghoAToken);

    uint128 newBucketCapacity = uint128(oldBucketCapacity) + 1;

    vm.warp(ghoSteward.MINIMUM_DELAY() + 1);
    ghoSteward.updateBucketCapacity(newBucketCapacity);

    (uint256 capacity, ) = iGhoToken.getFacilitatorBucket(ghoAToken);

    assertEq(capacity, newBucketCapacity);
    vm.stopPrank();
  }

  function testUpdateBucketCapacityWhenNotRiskCouncil() public {
    vm.startPrank(address(0));

    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    IGhoSteward ghoSteward = IGhoSteward(proposalPayload.GHO_STEWARD());
    vm.expectRevert('INVALID_CALLER');
    ghoSteward.updateBucketCapacity(1);
    vm.stopPrank();
  }
}
