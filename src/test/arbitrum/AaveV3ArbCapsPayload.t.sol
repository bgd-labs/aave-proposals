// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbCapsPayload} from '../../contracts/arbitrum/AaveV3ArbCapsPayload.sol';
import {BaseTest} from '../utils/BaseTest.sol';

contract AaveV3ArbCapsPayloadTest is ProtocolV3TestBase, BaseTest {
  AaveV3ArbCapsPayload public proposalPayload;

  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
  address public constant WBTC = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
  address public constant LINK = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;
  address public constant AAVE = 0xba5DdD1f9d7F570dc94a51479a000E3BCE967196;

  //20.3K WETH
  uint256 public constant WETH_CAP = 20_300;
  //2.1K WBTC
  uint256 public constant WBTC_CAP = 2_100;
  //350K LINK
  uint256 public constant LINK_CAP = 350_000;
  //2.5K AAVE
  uint256 public constant AAVE_CAP = 2_500;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 43236349);
    _setUp(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testProposalE2E() public {
    // we get all configs to later on check that payload only changes stEth
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    // 1. deploy l2 payload
    proposalPayload = new AaveV3ArbCapsPayload();

    // 2. execute l2 payload
    _execute(address(proposalPayload));

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase
      ._getReservesConfigs(AaveV3Arbitrum.POOL);

    //LINK
    ReserveConfig memory LinkConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      LINK
    );
    LinkConfig.supplyCap = LINK_CAP;
    ProtocolV3TestBase._validateReserveConfig(LinkConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WETH
    );
    WETHConfig.supplyCap = WETH_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      WBTC
    );
    WBTCConfig.supplyCap = WBTC_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);

    //AAVE
    ReserveConfig memory AAVEConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AAVE
    );
    AAVEConfig.supplyCap = AAVE_CAP;
    ProtocolV3TestBase._validateReserveConfig(AAVEConfig, allConfigsAfter);
  }
}
