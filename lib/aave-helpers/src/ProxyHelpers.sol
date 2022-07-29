// SPDX-License-Identifier: AGPL-3.0
pragma solidity >=0.7.5 <0.9.0;

import "forge-std/Vm.sol";

library ProxyHelpers {
    function getInitializableAdminUpgradeabilityProxyAdmin(Vm vm, address proxy) internal returns (address) {
        address slot = address(
            uint160(uint256(vm.load(
                    proxy,
                    0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
                ))));
        return slot;
    }
}