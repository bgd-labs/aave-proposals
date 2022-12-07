# Aave v3 cross-chain listing template

This template contains an opinionated smart contract template for creating proposals to list assets on the aave v3 pools that are controlled by cross-chain governance.

## About

To simplify the process of creating a cross-chain proposal this repository contains opinionated `CrosschainForwarder` contracts for `Polygon`, `Optimism` and `Arbitrum` abstracting away the complexity of bridging & cross-chain gas calculations.
All the forwarders follow the same pattern. They expect a payload to be deployed on L2 and to be executed with a parameterless `execute()` signature and via `DELEGATECALL`.

![visualization](/bridge-listing.png)

### Polygon

For a proposal to be executed on Polygon it needs to pass a mainnet governance proposal that sends an encoded payload via `sendMessageToChild(address,bytes)` on [FX_ROOT](https://etherscan.io/address/0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2#code)(mainnet) to [FX_CHILD](https://polygonscan.com/address/0x8397259c983751DAf40400790063935a11afa28a#code)(Polygon).
Once the state is synced to `FX_CHILD` on Polygon network it will queue the payload on [POLYGON_BRIDGE_EXECUTOR](https://polygonscan.com/address/0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772#code).

### Optimism

For a proposal to be executed on Optimism it needs to pass a mainnet governance proposal that sends an encoded payload via `sendMessage(address,bytes,uint32)` on [L1_CROSS_DOMAIN_MESSENGER](https://etherscan.io/address/0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1)(mainnet) to [L2_CROSS_DOMAIN_MESSENGER](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000007#code)(Optimism).
Once the state is `L2_CROSS_DOMAIN_MESSENGER` on Optimism it will queue the payload on [OPTIMISM_BRIDGE_EXECUTOR](https://optimistic.etherscan.io/address/0x7d9103572bE58FfE99dc390E8246f02dcAe6f611).

### Arbitrum

For a proposal to be executed on Arbitrum it needs to pass a mainnet governance proposal that sends an encoded payload via `unsafeCreateRetryableTicket{value: uint256}(address,uint256,uint256,address,address,uint256,uint256,bytes)` on [INBOX](https://etherscan.io/address/0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f)(mainnet). The Arbitrum bridge will then call the bridged calldata via the L2_ALIAS of the mainnet `msg.sender` (in this case is the aliased mainnet governance executor) which will queue the payload on [ARBITRUM_BRIDGE_EXECUTOR](https://arbiscan.io/address/0x7d9103572bE58FfE99dc390E8246f02dcAe6f611).

Caveat: Opposed to the other bridges, Arbitrum inbox bridge requires you to supply some gas.
For simplicity the `CrosschainForwarderArbitrum` expects some eth to be available on the [SHORT_EXECUTOR](https://etherscan.io/address/0xEE56e2B3D491590B5b31738cC34d5232F378a8D5).
You can check if you need to top-up the SHORT_EXECUTOR by calling `getRequiredGas(580)` on the `CrosschainForwarderArbitrum`.

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
make deploy-<mai|frax|op>
# Verify proposal
make verify-<mai|frax>
```

### Deploy L1 proposal

Make sure the referenced IPFS_HASH is properly encoded (check if the ipfs file is in json format and renders nicely on https://app.aave.com/governance/ipfs-preview/?ipfsHash=<encodedHash>).

```sh
make deploy-l1-<mai|frax|op>-proposal
```

## Creating the proposal

To create a proposal you have to do two things:

1. deploy the Polygon Payload ([see MiMatic](/src/contracts/polygon/MiMaticPayload.sol))
2. create the mainnet proposal ([see DeployL1Proposal](/script/DeployL1Proposal.s.sol))

While the order of actions is important as the mainnet proposal needs the l2 payload address, both actions can be performed by different parties / addresses.
The address creating the mainnet proposal requires 80k AAVE of proposition power.

## Deployed addresses

### This repository

#### Forwarders

- [CrosschainForwarderPolygon](https://etherscan.io/address/0x158a6bc04f0828318821bae797f50b0a1299d45b#code)
- [CrosschainForwarderOptimism](https://etherscan.io/address/0x5f5c02875a8e9b5a26fbd09040abcfdeb2aa6711#code)
- [CrosschainForwarderArbitrum](https://etherscan.io/address/0x2e2B1F112C4D79A9D22464F0D345dE9b792705f1#code)

#### ProposalPayloads

##### Polygon

- [MiMaticPayload](https://polygonscan.com/address/0x83fba23163662149b33dbc05cf1312df6dcba72b#code)
- [FraxPayload](https://polygonscan.com/address/0xa2f3f9534e918554a9e95cfa7dc4f763d02a0859#code)

##### Optimism

- [OpPayload](https://optimistic.etherscan.io/address/0x6f76EeDCB386fef8FC57BEE9d3eb46147e488eEF#code)

### Bridges

- [PolygonBridge: FxRoot](https://etherscan.io/address/0xfe5e5d361b2ad62c541bab87c45a0b9b018389a2#code)
- [PolygonBridge: PolygonBridgeExecutor](https://polygonscan.com/address/0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772#code)

- [OptimismBridge: L1CrossDomainMessenger](https://etherscan.io/address/0x25ace71c97b33cc4729cf772ae268934f7ab5fa1#readProxyContract)
- [OptimismBridge: OptimismBridgeExecutor](https://optimistic.etherscan.io/address/0x7d9103572be58ffe99dc390e8246f02dcae6f611#code)

- [ArbitrumBridge: Inbox](https://etherscan.io/address/0x4dbd4fc535ac27206064b68ffcf827b0a60bab3f#code)
- [ArtitrumBridge: ArbitrumBridgeExecutor](https://arbiscan.io/address/0x7d9103572be58ffe99dc390e8246f02dcae6f611#code)

## References

- [crosschain-bridge repository](https://github.com/aave/governance-crosschain-bridges#polygon-governance-bridge)
- [first ever Polygon bridge proposal](https://github.com/pakim249CAL/Polygon-Asset-Deployment-Generic-Executor)

## Misc

- the deploy script on Polygon currently requires the --legacy flag due to issues with Polygon gas estimation https://github.com/ethers-io/ethers.js/issues/2828#issuecomment-1073423774
