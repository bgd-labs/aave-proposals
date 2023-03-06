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


# ################ EXAMPLE ################
# The script section will be periodically cleaned up as each script will usually just be executed once
# The commented out section suits as an example for contributors and should not be altered

# Create proposal (always mainnet on Governance v2)
create-proposal-ledger :; forge script script/CreateMainnetProposals.s.sol:CreateCbETHProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
create-proposal-pk :; forge script script/CreateMainnetProposals.s.sol:CreateCbETHProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} -vvvv
# notice: mocking sender to be the ecosystem reserve so proposition power is enough in simulation
emit-create-proposal :; forge script script/CreateMainnetProposals.s.sol:SafeSinglePayloadProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# Deploy MAINNET payload
# Make sure you properly setup `ETHERSCAN_API_KEY_MAINNET` for verification
cb-ledger :;  forge script script/DeployMainnetPayload.s.sol:CbETH --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
cb-pk :;  forge script script/DeployMainnetPayload.s.sol:CbETH --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy POLYGON payload
# Make sure you properly setup `ETHERSCAN_API_KEY_POLYGON` for verification
mai-ledger :;  forge script script/DeployPolygonPayload.s.sol:MiMatic --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
mai-pk :;  forge script script/DeployPolygonPayload.s.sol:MiMatic --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy OPTIMISM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_OPTIMISM` for verification
op-ledger :;  forge script script/DeployOptimismPayload.s.sol:Op --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
op-pk :;  forge script script/DeployOptimismPayload.s.sol:Op --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy ARBITRUM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  forge script script/DeployArbitrumPayload.s.sol:ArbCaps --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
caps-pk :;  forge script script/DeployArbitrumPayload.s.sol:ArbCaps --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
# ################ EXAMPLE END #############

# YOUR SCRIPT GOES BELOW HERE

# Deploy MAINNET rescue mission short and long proposals
rescue-short-ledger :;  forge script script/CreateRescueMainnetProposals.s.sol:RescueShortProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
rescue-long-ledger :;  forge script script/CreateRescueMainnetProposals.s.sol:RescueLongProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# Deploy ARBITRUM caps update payload
deploy-wsteth-cap-payload :;  forge script script/DeployArbwstethCapPayload.s.sol:ArbwtstethSupplyCap --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
test-wsteth-payload :; forge test -vvv --match-contract AaveV3ArbwstETHCapsPayloadTest
create-wsteth-proposal :; forge script script/CreateARBWSTETHProposal.s.sol:ARBWSTETHProposal --rpc-url ${RPC_MAINNET} --legacy --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv
