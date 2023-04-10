// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IMilkman} from './interfaces/IMilkman.sol';

contract MockSwap {
  error SenderNotOwner();

  uint256 public amount = 1e12;

  address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
  address public constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xf447Bf3CF8582E4DaB9c34C5b261A7b6AD4D6bDD;

  function swap() external {
    if (msg.sender != 0x2fb7d6bEb9AD75c1ffD392681cC68171B8551107) revert SenderNotOwner();

    IERC20(WETH).approve(MILKMAN, amount);

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      amount,
      IERC20(WETH),
      IERC20(USDC),
      0x2fb7d6bEb9AD75c1ffD392681cC68171B8551107,
      PRICE_CHECKER,
      checkerData()
    );
  }

  function checkerData() internal pure returns (bytes memory) {
    uint24[] memory fees = new uint24[](1);
    fees[0] = 5;

    address[] memory path = new address[](2);
    path[0] = WETH;
    path[1] = USDC;

    bytes memory data = abi.encode(path, fees);

    return abi.encode(200, data);
  }
}
