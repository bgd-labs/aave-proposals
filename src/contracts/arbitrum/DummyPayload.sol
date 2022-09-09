// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

 * @dev This payload lists FRAX as collateral and borrowing asset on Aave V3 Polygon
 * - Parameter snapshot: https://snapshot.org/#/aave.eth/proposal/0xa464894c571fecf559fab1f1a8daf514250955d5ed2bc21eb3a153d03bbe67db
 * Opposed to the suggested parameters this proposal will
 * - Lowering the suggested 50M ceiling to a 2M ceiling
 * - Adding a 50M supply cap
 * - The eMode lq treshold will be 97.5, instead of the suggested 98% as the parameters are per emode not per asset
 * - The reserve factor will be 10% instead of 5% to be consistent with other stable coins
 */
contract DummyPayload is IProposalGenericExecutor {
  function execute() external override {

  }
}
