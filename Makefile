# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes

test   :; forge test -vvv

test-usdt-v3-ethereum :; forge test -vvv --match-contract AaveV3EthUSDTPayloadTest

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md


# The script section will be periodically cleaned up as each script will usually just be executed once
# The commented out section suits as an example for contributors

# Create proposal (always mainnet on Governance v2)
# cbETH-proposal-ledger :; forge script script/CreateMainnetProposals.s.sol:CreateCbETHProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
# cbETH-proposal-pk :; forge script script/CreateMainnetProposals.s.sol:CreateCbETHProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} -vvvv

# Make sure you properly setup `ETHERSCAN_API_KEY_MAINNET` for verification
# Deploy MAINNET payload
# mai-ledger :;  forge script script/DeployMainnetPayload.s.sol:CbETH --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
# mai-pk :;  forge script script/DeployMainnetPayload.s.sol:CbETH --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Make sure you properly setup `ETHERSCAN_API_KEY_POLYGON` for verification
# Deploy POLYGON payload
# mai-ledger :;  forge script script/DeployPolygonPayload.s.sol:MiMatic --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
# mai-pk :;  forge script script/DeployPolygonPayload.s.sol:MiMatic --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Make sure you properly setup `ETHERSCAN_API_KEY_OPTIMISM` for verification
# Deploy OPTIMISM payload
# op-ledger :;  forge script script/DeployOptimismPayload.s.sol:Op --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
# op-pk :;  forge script script/DeployOptimismPayload.s.sol:Op --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
# Deploy ARBITRUM payload
# op-ledger :;  forge script script/DeployArbitrumPayload.s.sol:ArbCaps --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
# op-pk :;  forge script script/DeployArbitrumPayload.s.sol:ArbCaps --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# deploy LDO Emission admin payloads
deploy-arb-ldo-emission-admin :; forge script script/DeployLDOEmissionAdminProposals.s.sol:DeployArbLDOEmissionAdmin --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM} --verify -vvvv
deploy-eth-ldo-emission-admin :;forge script script/DeployLDOEmissionAdminProposals.s.sol:DeployEthLDOEmissionAdmin --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify -vvvv
deploy-opt-ldo-emission-admin :; forge script script/DeployLDOEmissionAdminProposals.s.sol:DeployOptLDOEmissionAdmin --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM} --verify -vvvv

usdt-strategy :;  forge script script/DeployUSDTV3Utils.s.sol:DeployUSDTStrategy --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

usdt-payload :;  forge script script/DeployUSDTV3Utils.s.sol:DeployMainnetPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

reth-payload :;  forge script script/DeployMainnetPayload.s.sol:rETH --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

xsushi-feed-payload :;  forge script script/DeployMainnetPayload.s.sol:AaveV2SwapxSushiOracle --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv
xsushi-feed-proposal :; forge script script/CreateMainnetProposals.s.sol:SwapXSushiPriceFeedPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv

lusd-strategy :;  forge script script/DeployLUSDV3Utils.s.sol:DeployLUSDStrategy --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

test-lusd-v3-ethereum :; forge test -vvv --match-contract AaveV3EthLUSDPayloadTest

lusd-strategy :;  forge script script/DeployLUSDV3Utils.s.sol:DeployLUSDStrategy --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

test-lusd-v3-ethereum :; forge test -vvv --match-contract AaveV3EthLUSDPayloadTest

mai-payload :;  forge script script/DeployMaiPolygonPayload.s.sol:MAI --rpc-url ${RPC_POLYGON}  --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON} -vvvv

test-mai-payload :; forge test -vvv --match-contract MAIV3PolCapsPayloadTest

wsteth-strategy :;  forge script script/DeployWSTETHV3Utils.s.sol:DeployWSTETHStrategy --rpc-url ${RPC_OPTIMISM} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM} -vvvv

wsteth-payload :;  forge script script/DeployWSTETHOPV3Payload.s.sol:WSTETH --rpc-url ${RPC_OPTIMISM} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM} -vvvv

create-wsteth-proposal :; forge script script/CreateOPWSTETHProposal.s.sol:OPWSTETHProposal --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

test-wsteth-payload :; forge test -vvv --match-contract AaveV3OPWSTETHPayloadTest

cbeth-cap-payload :; forge script script/DeployCbETHCapsPayload.s.sol:CBETH --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

test-cbeth-cap-payload :; forge test -vvv --match-contract AaveV3EthCbETHCapsPayloadTest

create-cbeth-proposal :; forge script script/CreateCBETHCapProposal.s.sol:CBETHCAPProposal --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

freeze-busd-payload :; forge script script/AaveV2EthFreezeBUSD.s.sol:AaveV2EthFreezeBUSD --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

test-freeze-busd :; forge test -vvv --match-contract AaveV2EthBUSDFreezeTest

create-freeze-busd-proposal :; forge script script/CreateBUSDFreeze.s.sol:FreezeBUSDProposal --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv