// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title ACI Service Provider 6 month Proposal
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbff353c13861818ed952874dd76a04e4b97570edc0513bfc2eed64cd5277b404
 * - Discussion: https://governance.aave.com/t/arfc-aci-service-provider-6-month-proposal/12513
 */
contract AaveV3ACIProposal_20230411 is IProposalGenericExecutor {
  address public constant ACI_TREASURY = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;
  address public constant AUSDT = AaveV2EthereumAssets.USDT_A_TOKEN;
  address public constant COLLECTOR = address(AaveV2Ethereum.COLLECTOR);
  uint256 public constant STREAM_AMOUNT = 250000e6;
  uint256 public constant STREAM_DURATION = 180 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_A_USDT =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      COLLECTOR,
      ACI_TREASURY,
      ACTUAL_STREAM_AMOUNT_A_USDT,
      AUSDT,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
