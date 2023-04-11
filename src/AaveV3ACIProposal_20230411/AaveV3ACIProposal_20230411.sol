// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveEcosystemReserveController, AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title ACI Service Provider 6 month Proposal
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbff353c13861818ed952874dd76a04e4b97570edc0513bfc2eed64cd5277b404
 * - Discussion: https://governance.aave.com/t/arfc-aci-service-provider-6-month-proposal/12513
 */

contract ACIStreamPayload is IProposalGenericExecutor {
  address public constant ACI_TREASURY = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;
  address public constant AUSDT = AaveV2EthereumAssets.USDT_A_TOKEN;
  address public constant RESERVE_CONTROLLER = AaveV2Ethereum.COLLECTOR_CONTROLLER;
  uint256 public constant STREAM_AMOUNT = 250000e6;
  uint256 public constant STREAM_DURATION = 180 days;
  uint256 public constant STREAM_START = 1 days;
  uint256 public constant STREAM_END = STREAM_START + STREAM_DURATION;

  // Add a small amount to satisfy deposit % vars.duration == 0 contract condition.
  uint256 public constant ACTUAL_STEAM_AMOUNT = STREAM_AMOUNT + 15552000;

  function execute() external {
    IAaveEcosystemReserveController(RESERVE_CONTROLLER).createStream(
      RESERVE_CONTROLLER,
      ACI_TREASURY,
      ACTUAL_STEAM_AMOUNT,
      AUSDT,
      block.timestamp + STREAM_START,
      STREAM_START + STREAM_END
    );
  }
}
