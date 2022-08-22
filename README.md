# Aave v3 cross-chain listing template

This template contains an opinionated smart contract template for creating proposals to list assets on the aave polygon v3 market.

For a proposal to be executed on polygon it needs to pass mainnet governance proposal that sends an encoded payload via `sendMessageToChild(address,bytes)` on [FX_ROOT](https://etherscan.io/address/0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2#code)(mainnet) to [FX_CHILD](https://polygonscan.com/address/0x8397259c983751DAf40400790063935a11afa28a#code)(polygon). Once the state is synced to `FX_CHILD` on polygon network it will queue the payload on [POLYGON_BRIDGE_EXECUTOR](https://polygonscan.com/address/0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772#code).

## About

To simplify the process of creating a cross chain proposal this repository contains an opinionated [CrosschainForwarderPolygon](/src/contracts/polygon/CrosschainForwarderPolygon.sol) which expects a payload address deployed on the polygon network as the only parameter. The mainnet proposal payload will then be a simple `execute()` signature with `DELEGATECALL` enabled.

![visualization](/bridge-listing.png)

## Getting started

### Setup environment

```sh
cp .env.example .env
```

### Build

```sh
forge build
```

### Test

```sh
forge test
```

### Deploy L2 proposal

```sh
# Deploy proposal
make deploy-<mai|frax>-<ledger|pk>
# Verify proposal
make verify-<mai|frax>
```

### Deploy L1 proposal

Make sure the referenced IPFS_HASH is properly encoded (check if the ipfs file is in json format and renders nicely on https://app.aave.com/governance/ipfs-preview/?ipfsHash=<encodedHash>).

```sh
make deploy-l1-<mai|frax>-proposal-<ledger|pk>
```

## Creating the proposal

To create a proposal you have to do two things:

1. deploy the Polygon Payload ([see MiMatic](/src/contracts/polygon/MiMaticPayload.sol))
2. create the mainnet proposal ([see DeployL1Proposal](/script/DeployL1Proposal.s.sol))

While the order of actions is important as the mainnet proposal needs the l2 payload address, both actions can be performed by different parties / addresses.
The address creating the mainnet proposal requires 80k AAVE of proposition power.

## Deployed addresses

- [CrosschainForwarderPolygon](https://etherscan.io/address/0x158a6bc04f0828318821bae797f50b0a1299d45b#code)
- [MiMaticPayload](https://polygonscan.com/address/0x83fba23163662149b33dbc05cf1312df6dcba72b#code)
- [FraxPayload](https://polygonscan.com/address/0xa2f3f9534e918554a9e95cfa7dc4f763d02a0859#code)

## References

- [crosschain-bridge repository](https://github.com/aave/governance-crosschain-bridges#polygon-governance-bridge)
- [first ever polygon bridge proposal](https://github.com/pakim249CAL/Polygon-Asset-Deployment-Generic-Executor)

## Misc

- the deploy script currently requires the --legacy flag due to issues with polygon gas estimation https://github.com/ethers-io/ethers.js/issues/2828#issuecomment-1073423774
- some of the tests are currently commented out due to a bug on foundry causing public library methods to revert https://github.com/foundry-rs/foundry/issues/2549
