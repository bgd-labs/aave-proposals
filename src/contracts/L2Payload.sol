// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';

interface IProposalGenericExecutor {
    function execute() external;
}

contract L2Payload is IProposalGenericExecutor {
     function execute() external override {
        console.log('yay executed');
     }
}
