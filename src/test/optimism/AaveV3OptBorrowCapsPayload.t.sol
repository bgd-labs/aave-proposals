// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AddressAliasHelper} from 'governance-crosschain-bridges/contracts/dependencies/arbitrum/AddressAliasHelper.sol';
import {AaveV3OptBorrowCapsPayload} from '../../contracts/optimism/AaveV3OptBorrowCapsPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3OptBorrowCapsPayloadTest is
  ProtocolV3TestBase,
  TestWithExecutor
{
  AaveV3OptBorrowCapsPayload public proposalPayload;

  address public constant LINK = 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6;
  address public constant WBTC = 0x68f180fcCe6836688e9084f035309E29Bf0A2095;
  address public constant WETH = 0x4200000000000000000000000000000000000006;

  uint256 public constant LINK_CAP = 141_900;
  uint256 public constant WBTC_CAP = 605;
  uint256 public constant WETH_CAP = 19_745;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 44920020);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsOpt() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Optimism.POOL
    );

    // 1. deploy l2 payload
    proposalPayload = new AaveV3OptBorrowCapsPayload();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    // 5. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Optimism.POOL
    );

    //LINK
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      LINK
    );
    LinkConfig.borrowCap = LINK_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WETH
    );
    WETHConfig.borrowCap = WETH_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WBTC
    );
    WBTCConfig.borrowCap = WBTC_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);
  }
}
