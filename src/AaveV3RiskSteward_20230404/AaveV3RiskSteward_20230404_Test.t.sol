// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {IACLManager, IPoolConfigurator, IPoolDataProvider} from 'aave-address-book/AaveV3.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3_0_1TestBase, ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3RiskSteward_20230404} from './AaveV3RiskSteward_20230404.sol';
import {CapsPlusRiskSteward} from 'aave-helpers/riskstewards/CapsPlusRiskSteward.sol';
import {ICapsPlusRiskSteward} from 'aave-helpers/riskstewards/ICapsPlusRiskSteward.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

contract AaveV3RiskSteward_20230321_Test is TestWithExecutor, ProtocolV3_0_1TestBase {
  address public constant user = address(42);
  ICapsPlusRiskSteward public steward;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17020741);
    steward = new CapsPlusRiskSteward(
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER,
      IAaveV3ConfigEngine(AaveV3Ethereum.LISTING_ENGINE),
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

    IAaveV3ConfigEngine.CapsUpdate[] memory capUpdates = new IAaveV3ConfigEngine.CapsUpdate[](1);
    capUpdates[0] = IAaveV3ConfigEngine.CapsUpdate(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      daiSupplyCapBefore * 2,
      daiBorrowCapBefore * 2
    );

    vm.startPrank(user);
    steward.updateCaps(capUpdates);

    (uint256 daiBorrowCapAfter, uint256 daiSupplyCapAfter) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.DAI_UNDERLYING);

    ICapsPlusRiskSteward.Debounce memory debounce = steward.getTimelock(
      AaveV3EthereumAssets.DAI_UNDERLYING
    );
    assertEq(daiBorrowCapAfter, capUpdates[0].borrowCap);
    assertEq(daiSupplyCapAfter, capUpdates[0].supplyCap);
    assertEq(debounce.supplyCapLastUpdated, block.timestamp);
    assertEq(debounce.borrowCapLastUpdated, block.timestamp);
  }
}
