// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {IFxStateSender} from '../interfaces/IFx.sol';

contract GenericL2Executor {
  address public immutable FX_ROOT_ADDRESS;
  address public immutable ACL_ADMIN;

  constructor(address fxRoot, address aclAdmin) {
    FX_ROOT_ADDRESS = fxRoot;
    ACL_ADMIN = aclAdmin;
  }

  function execute(address l2PayloadContract) public {
    address[] memory targets = new address[](1);
    targets[0] = l2PayloadContract;
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
    IFxStateSender(FX_ROOT_ADDRESS).sendMessageToChild(ACL_ADMIN, actions);
  }
}
