// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IACLManager, IPoolConfigurator, IPoolDataProvider} from 'aave-address-book/AaveV3.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3_0_1TestBase, ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3RiskSteward_20230404} from './AaveV3RiskSteward_20230404.sol';
import {CapsPlusRiskSteward, RiskStewardLibrary} from './CapsPlusRiskSteward.sol';

contract AaveV3RiskSteward_20230321_Test is TestWithExecutor, ProtocolV3_0_1TestBase {
  address public constant user = address(42);
  CapsPlusRiskSteward public steward;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17020741);
    steward = new CapsPlusRiskSteward(
      AaveV3Ethereum.POOL_CONFIGURATOR,
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER,
      user
    );
    AaveV3RiskSteward_20230404 proposalPayload = new AaveV3RiskSteward_20230404(
      AaveV3Ethereum.ACL_MANAGER,
      address(steward)
    );

    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
    _executePayload(address(proposalPayload));
  }

  function test_increaseCapsMax() public {
    (uint256 daiBorrowCapBefore, uint256 daiSupplyCapBefore) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.DAI_UNDERLYING);

    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      daiSupplyCapBefore * 2,
      daiBorrowCapBefore * 2
    );

    vm.startPrank(user);
    steward.updateCaps(capUpdates);

    (uint256 daiBorrowCapAfter, uint256 daiSupplyCapAfter) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.DAI_UNDERLYING);

    (uint40 supplyCapLastUpdated, uint40 borrowCapLastUpdated) = steward.timelocks(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    assertEq(daiBorrowCapAfter, capUpdates[0].borrowCap);
    assertEq(daiSupplyCapAfter, capUpdates[0].supplyCap);
    assertEq(supplyCapLastUpdated, block.timestamp);
    assertEq(borrowCapLastUpdated, block.timestamp);
  }

  function test_keepCurrent() public {
    (uint256 daiBorrowCapBefore, uint256 daiSupplyCapBefore) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.DAI_UNDERLYING);

    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      RiskStewardLibrary.KEEP_CURRENT,
      RiskStewardLibrary.KEEP_CURRENT
    );

    vm.startPrank(user);
    steward.updateCaps(capUpdates);

    (uint256 daiBorrowCapAfter, uint256 daiSupplyCapAfter) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.DAI_UNDERLYING);

    (uint40 supplyCapLastUpdated, uint40 borrowCapLastUpdated) = steward.timelocks(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    assertEq(daiBorrowCapAfter, daiBorrowCapBefore);
    assertEq(daiSupplyCapAfter, daiSupplyCapBefore);
    assertEq(supplyCapLastUpdated, 0);
    assertEq(borrowCapLastUpdated, 0);
  }

  function test_invalidCaller() public {
    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      RiskStewardLibrary.KEEP_CURRENT,
      RiskStewardLibrary.KEEP_CURRENT
    );

    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.INVALID_CALLER)));
    }
  }

  function test_updateSupplyCapBiggerMax() public {
    (, uint256 daiSupplyCapBefore) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      (daiSupplyCapBefore * 2) + 1,
      RiskStewardLibrary.KEEP_CURRENT
    );

    vm.startPrank(user);
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.UPDATE_BIGGER_MAX)));
    }
  }

  function test_updateBorrowCapBiggerMax() public {
    (uint256 daiBorrowCapBefore, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      RiskStewardLibrary.KEEP_CURRENT,
      (daiBorrowCapBefore * 2) + 1
    );

    vm.startPrank(user);
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.UPDATE_BIGGER_MAX)));
    }
  }

  function test_updateSupplyCapNotStrictlyHigher() public {
    (, uint256 daiSupplyCapBefore) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      daiSupplyCapBefore,
      RiskStewardLibrary.KEEP_CURRENT
    );

    vm.startPrank(user);
    // should fail when cap is equal current value
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.NOT_STICTLY_HIGHER)));
    }

    // should also fail when lower
    capUpdates[0].supplyCap -= 1;
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.NOT_STICTLY_HIGHER)));
    }
  }

  function test_updateBorrowCapNotStrictlyHigher() public {
    (uint256 daiBorrowCapBefore, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      RiskStewardLibrary.KEEP_CURRENT,
      daiBorrowCapBefore
    );

    vm.startPrank(user);
    // should fail when cap is equal current value
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.NOT_STICTLY_HIGHER)));
    }

    // should also fail when lower
    capUpdates[0].borrowCap -= 1;
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.NOT_STICTLY_HIGHER)));
    }
  }

  function test_debounce() public {
    (uint256 daiBorrowCapBefore, ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );

    RiskStewardLibrary.CapUpdate[] memory capUpdates = new RiskStewardLibrary.CapUpdate[](1);
    capUpdates[0] = RiskStewardLibrary.CapUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      RiskStewardLibrary.KEEP_CURRENT,
      daiBorrowCapBefore + 1
    );

    vm.startPrank(user);
    steward.updateCaps(capUpdates);

    capUpdates[0].borrowCap += 1;
    try steward.updateCaps(capUpdates) {
      require(false, 'MUST_FAIL');
    } catch Error(string memory reason) {
      require(
        keccak256(bytes(reason)) == keccak256(bytes(RiskStewardLibrary.DECOUNCE_NOT_RESPECTED))
      );
    }

    vm.warp(block.timestamp + steward.MINIMUM_DELAY() + 1);
    steward.updateCaps(capUpdates);
  }
}
