// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {AaveGovernanceV2, IExecutorWithTimelock} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

contract Deploy is Script {
  address public constant FX_ROOT_ADDRESS = 0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2;
  address public constant FX_CHILD_ADDRESS = 0x8397259c983751DAf40400790063935a11afa28a;
  address public constant AAVE_WHALE =
    address(0x25F2226B597E8F9514B3F68F00f494cF4f286491);
  address public constant BRIDGE_ADMIN = 0x0000000000000000000000000000000000001001;

  function _createL2PayloadExecutor(address l2payload) internal pure returns(bytes memory) {
    address[] memory targets = new address[](1);
    targets[0] = l2payload; // the payload address on the sidechain
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute()';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = '';
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    bytes memory actions = abi.encode(
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls
    );
    return abi.encode(AaveV3Polygon.ACL_ADMIN, actions);
  }

  function createL1Proposal(address l2payload) public returns(uint256) {
    vm.startPrank(AAVE_WHALE);
    bytes memory callData = _createL2PayloadExecutor(l2payload);
    address[] memory targets = new address[](1);
    targets[0] = FX_ROOT_ADDRESS; // the payload address on the sidechain
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'sendMessageToChild(address,bytes)';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = callData;
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = false;
    return AaveGovernanceV2.GOV.create(
      IExecutorWithTimelock(AaveGovernanceV2.SHORT_EXECUTOR),
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls,
      bytes32(0)
    );
  }

  function run() external {
    vm.startBroadcast();
    vm.stopBroadcast();
  }
}
