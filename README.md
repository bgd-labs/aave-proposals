# BGD forge template

Basic template with prettier and rest configuration

To create a new project using this template run
```shell
$ forge init --template bgd-labs/bgd-forge-template my_new_project
```

## Recommended modules

[bgd-labs/solidity-utils](https://github.com/bgd-labs/solidity-utils) - common contracts we use everywhere, ie transparent proxy and around

[bgd-labs/aave-address-book](https://github.com/bgd-labs/aave-address-book) - the best and only source about all deployed Aave ecosystem related contracts across all the chains

[bgd-labs/aave-helpers](https://github.com/bgd-labs/aave-helpers) - useful utils for integration, and not only testing related to Aave ecosystem contracts

[Rari-Capital/solmate](https://github.com/Rari-Capital/solmate)  - one of the best sources of base contracts for ERC20, ERC21, which will work with transparent proxy pattern out of the box

[OpenZeppelin/openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) - another very reputable and well organized source of base contracts for tokens, access control and many others

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for instructions on how to install and use Foundry.


