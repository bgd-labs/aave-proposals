# Aave proposals

This repository contains various proposals targeting the Aave governance.
In addition to the actual proposals this repository also contains tooling to standardize certain protocol tasks. The tooling documentation is co-located with the relevant smart contracts.

## Tooling

### Cross-chain forwarders

The cross-chain-forwarders are opinionated contracts for proposals targeting `polygon`, `optimism` and `arbitrum`. For detailed documentation checkout the [docs](./src/lib/crosschainforwarders/).

### Listing engine

TBA

### Stewards

TBA

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for detailed instructions on how to install and use Foundry.
The template ships with sensible default so you can use default `foundry` commands without resorting to `MakeFile`.

### Setup

```sh
cp .env.example .env
forge install
yarn
```

### Test

```sh
forge test
```

### Simulate

While a proposal should be tested throughout, it usually is a good idea to simulate execution on a fork. Therefore this repository comes with the [aave-tenderly-cli](https://github.com/bgd-labs/aave-tenderly-cli) node package which can be used to streamline fork creation.

Follow the [setup instructions](https://github.com/bgd-labs/aave-tenderly-cli#setup-env) and run

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

Refer to the [aip repo](https://github.com/aave/aip) for instructions on aip creation.
Once your pr is successfully merged an [encodedHash](https://github.com/aave/aip/pull/276/files#diff-1c9f2c11da854f3177ad4ef0558e3caf4c22b47752330082ace7e6b6f2dc25e9R4) will be generated, which you will need for the final step.

### 3. Create proposal

The proposal requires at least one `payload address` and the `encodedHash`.
Make sure the referenced `encodedHash` is properly encoded (check if the ipfs file is in json format and renders nicely on https://app.aave.com/governance/ipfs-preview/?ipfsHash=<encodedHash>).

To create the proposal you need to adjust:

- [CreateMainnetProposals](./script/CreateMainnetProposals.s.sol) according to your needs.

Once adjusted, you need to create the proposal.
Checkout [Makefile](./Makefile) for reference.

:tada:
