# Aave proposals

This repository contains various proposals targeting the Aave governance.
In addition to the actual proposals this repository also contains tooling to standardize certain protocol tasks. The tooling documentation is co-located with the relevant smart contracts.

## Tooling

### Cross-chain forwarders

The cross-chain-forwarders are opinionated contracts for proposals targeting `polygon`, `optimism` and `arbitrum`. For detailed documentation checkout the [docs](./src/lib/crosschainforwarders/).

### Config engine

The AaveV3ConfigEngine ([Docs](https://github.com/bgd-labs/aave-helpers/tree/master/src/v3-config-engine#how-to-use-the-engine)) is a helper smart contract to abstract good practices when doing "admin" interactions with the Aave v3 protocol, but built on top, without touching the core contracts.

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for detailed instructions on how to install and use Foundry.
The template ships with sensible default so you can use default `foundry` commands without resorting to `MakeFile`.

### Setup

```sh
cp .env.example .env
forge install
yarn
```

### Create an aip

This repository includes a generator to help you bootstrap the required files for an `AIP`.
To generate a proposal you need to run: `yarn generate -a "BGD labs" --chains Ethereum Polygon -pv V3 --name TestProposal --configEngine`

To get a full list of available commands run `yarn generate --help`

```sh
Usage: proposal-generator [options]

CLI to generate aave proposals

Options:
  -V, --version                    output the version number
  -f, --force                      force creation (might overwrite existing files)
  -cfg, --configEngine             extends config engine
  -name, --name <string>           name of the proposal (e.g. CapsIncrease)
  -ch, --chains <letters...>        (choices: "Ethereum", "Optimism", "Arbitrum", "Polygon", "Avalanche", "Fantom", "Harmony", "Metis")
  -pv, --protocolVersion <string>   (choices: "V2", "V3")
  -t, --title <string>             aip title
  -a, --author <string>            author
  -d, --discussion <string>        forum link
  -s, --snapshot <string>          snapshot link
  -h, --help                       display help for command
```

If you have any feedback regarding the generator (bugs, improvements, features), don't hesitate and put it [here](https://github.com/bgd-labs/aave-proposals/issues/200)!

### Test

```sh
# You can use vanilla forge to customize your test
# https://book.getfoundry.sh/reference/forge/forge-test
forge test
# We also provide a script with sensible defaults to just test a single contract matching a filter
make test-contract filter=ENS
```

### Deploy

The makefile contains some generic templates for proposal deployments.
To deploy a contract you can run `make deploy-ledger contract=pathToContract:Contract chain=chainAlias`.

```sh
# example
make deploy-ledger contract=script/CreateProposals.s.sol:MultiPayloadProposal chain=mainnet
make deploy-pk contract=script/CreateProposals.s.sol:MultiPayloadProposal chain=mainnet
# both targets also expose a `dry` option you can run via
make deploy-ledger contract=script/CreateProposals.s.sol:MultiPayloadProposal chain=mainnet dry=true
make deploy-pk contract=script/CreateProposals.s.sol:MultiPayloadProposal chain=mainnet dry=true
```

### Simulate

While a proposal should be tested throughout, it usually is a good idea to simulate execution on a fork. Therefore this repository comes with the [aave-tenderly-cli](https://github.com/bgd-labs/aave-tenderly-cli) node package which can be used to streamline fork creation.

Setup your `.env` accordingly or follow the [setup instructions](https://github.com/bgd-labs/aave-tenderly-cli#setup-env) for global configuration. Now you can

```sh
yarn simulate:<mainnet|polygon|...> -- <artifactPath>

# example:
# yarn simulate:polygon -- ./out/AaveV3EthAddCRVPoolPayload.sol/AaveV3EthAddCRVPoolPayload.json
```

to generate a tenderly fork you can share with your team.

## Proposal creation

To create a proposal you have to do three things:

1. deploy the payload
2. create an aip
3. create the mainnet proposal

While the first two steps can be performed in parallel, the final proposal creation relies on (1) and (2).
Every step can in theory be performed by a different entity.

The address creating the mainnet proposal(3) requires 80k AAVE of proposition power.

### 1. Deploy payload

The payload is always deployed on the chain it affects.
Therefore you need to adjust the relevant script accordingly:

- [DeployMainnetPayload](./script/DeployMainnetPayload.s.sol) for payloads targeting mainnet pools
- [DeployPolygonPayload](./script/DeployPolygonPayload.s.sol) for payloads targeting polygon pools
- [DeployArbitrumPayload](./script/DeployArbitrumPayload.s.sol) for payloads targeting arbitrum pools
- [DeployOptimismPayload](./script/DeployOptimismPayload.s.sol) for payloads targeting optimism pools

Once adjusted, you need to deploy it to receive the `payload address`.
Checkout [Makefile](./Makefile) for reference.

### 2. Create an aip

The aip can be co-located with the proposal code as a markdown file.
This repository will manage the upload to ipfs automatically once a pr is merged to `main`.
Alternatively you can submit your aip to the [aave/aip](https://github.com/aave/aip) repository or upload it yourself.

### 3. Create proposal

The proposal requires at least one `payload address` and the `encodedHash`.

To create the proposal you need to adjust:

- [CreateMainnetProposals](./script/CreateProposals.s.sol) according to your needs.

Once adjusted, you need to create the proposal.
Checkout [Makefile](./Makefile) for reference.

:tada:
