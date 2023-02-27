// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {AaveV3OptCapsPayload} from '../../contracts/optimism/AaveV3OptCapsPayload022123.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3OptCapsPayloadTest022123 is ProtocolV3TestBase, TestWithExecutor {
  AaveV3OptCapsPayload public proposalPayload;

  address public constant WBTC = 0x68f180fcCe6836688e9084f035309E29Bf0A2095;
  address public constant SUSD = 0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 75442850);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testProposalE2E() public {
    // we get all configs to later on check that payload only changes OP
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Optimism.POOL);

    // 1. deploy l2 payload
    proposalPayload = new AaveV3OptCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Optimism.POOL);

    // WBTC
    ReserveConfig memory wBTCConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, WBTC);
    wBTCConfig.liquidationBonus = 10940;

    ProtocolV3TestBase._validateReserveConfig(wBTCConfig, allConfigsAfter);

    // SUSD
    ReserveConfig memory sUSDConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, SUSD);
    sUSDConfig.liquidationBonus = 10540;
    ProtocolV3TestBase._validateReserveConfig(sUSDConfig, allConfigsAfter);
  }
}
