# BGD v3 bridge listing example

This template contains a code example for executing code on l2 via bridge executor.

The flow here is:
- create payload on l2
- create a proposal on l1 which will call `sendMessageToChild(address,bytes)` where `address` is the ACL_ADMIN on the receiving chain and `bytes` the payload to be executed emitting `(uint256 id, address contractAddress, bytes data)`
- on l2 `onStateReceive(uint256,bytes)` will arrive where `uint256` is the `id` emitted and `bytes` is `(address rootMessageSender, address receiver, bytes memory data)`

## Recommended modules

[bgd-labs/solidity-utils](https://github.com/bgd-labs/solidity-utils) - common contracts we use everywhere, ie transparent proxy and around

[bgd-labs/aave-address-book](https://github.com/bgd-labs/aave-address-book) - the best and only source about all deployed Aave ecosystem related contracts across all the chains

[bgd-labs/aave-helpers](https://github.com/bgd-labs/aave-helpers) - useful utils for integration, and not only testing related to Aave ecosystem contracts

[Rari-Capital/solmate](https://github.com/Rari-Capital/solmate)  - one of the best sources of base contracts for ERC20, ERC21, which will work with transparent proxy pattern out of the box

[OpenZeppelin/openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) - another very reputable and well organized source of base contracts for tokens, access control and many others

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for instructions on how to install and use Foundry.


