# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes

test   :; forge test -vvv

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

git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
