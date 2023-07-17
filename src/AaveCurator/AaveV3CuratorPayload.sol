// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import {AaveCurator} from './AaveCurator.sol';
import {TokenAddresses} from "./TokenAddresses.sol";

/**
 * @title Launch AaveCurator
 * @author Llama
 * Governance: TODO
 * Snapshot: TODO
 */
contract AaveV3CuratorPayload is IProposalGenericExecutor {
    function execute() external {
        AaveCurator curator = new AaveCurator();

        address[1] memory tokens = TokenAddresses.getTokens();
        for (uint256 i = 0; i < 5; ++i) {
            AaveV2Ethereum.COLLECTOR.transfer(
                tokens[i],
                address(curator),
                IERC20(tokens[i]).balanceOf(address(AaveV2Ethereum.COLLECTOR))
            );

            curator.swap();
        }
    }
}
