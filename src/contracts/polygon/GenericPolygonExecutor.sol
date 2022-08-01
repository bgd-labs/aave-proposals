// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IFxStateSender} from '../../interfaces/IFx.sol';

/**
 * @dev This executor is a generic wrapper to be used with FX bridges (https://github.com/fx-portal/contracts)
 * It encodes a parameterless `execute()` with delegate calls and a specified target.
 * This encoded abi is then send to the FX-root to be synced to the FX-child.
 */
contract GenericPolygonExecutor {
  address public constant FX_ROOT_ADDRESS =
    0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2;
  address public constant POLYGON_BRIDGE_EXECUTOR =
    0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772;

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
    IFxStateSender(FX_ROOT_ADDRESS).sendMessageToChild(
      POLYGON_BRIDGE_EXECUTOR,
      actions
    );
  }
}
