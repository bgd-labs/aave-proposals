// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Optimism} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OptWSTETHListingPayload} from '../../contracts/optimism/AaveV3OptWSTETHListingPayload.sol';

contract AaveV3OptWSTETHListingPayloadTest is ProtocolV3TestBase, TestWithExecutor {}
