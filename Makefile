# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes

test   :; forge test -vvv

test-ageur-jeur-freeze :; forge test -vvv --match-contract AaveV3PolJEURAGEURFreeze && make git-diff before=./reports/0x794a61358D6845594F94dc1DB02A252b5b4814aD_pre-agEUR-freezing.md after=./reports/0x794a61358D6845594F94dc1DB02A252b5b4814aD_post-agEUR-freezing.md out=diff-agEUR-freezing && make git-diff before=./reports/0x794a61358D6845594F94dc1DB02A252b5b4814aD_pre-jEUR-freezing.md after=./reports/0x794a61358D6845594F94dc1DB02A252b5b4814aD_post-jEUR-freezing.md out=diff-jEUR-freezing

# Deploy L2 Polygon proposal payloads
deploy-mai :;  forge script script/DeployPolygonMiMatic.s.sol:DeployPolygonMiMatic --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-frax :;  forge script script/DeployPolygonFrax.s.sol:DeployPolygonFrax --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# Deploy L2 optimism proposals payloads
deploy-op :;  forge script script/DeployOptimismOp.s.sol:DeployOptimismOp --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-op-caps :;  forge script script/DeployOptimismCaps.s.sol:DeployOptimismCaps --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-op-caps-dry-run :;  forge script script/DeployOptimismCaps.s.sol:DeployOptimismCaps --rpc-url optimism --legacy -vvvv

deploy-op-caps-010423 :;  forge script script/DeployOptimismCaps010423.s.sol:DeployOptimismCaps --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-op-caps-dry-run-010423 :;  forge script script/DeployOptimismCaps010423.s.sol:DeployOptimismCaps --rpc-url optimism --legacy -vvvv

# deploy borrow caps:
deploy-op-borrow-caps :;  forge script script/DeployBorrowCaps.s.sol:DeployOptimismCaps --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${OPTISCAN_API_KEY} --verify -vvvv
deploy-pol-borrow-caps :;  forge script script/DeployBorrowCaps.s.sol:DeployPolygonCaps --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${POLYGON_API_KEY} --verify -vvvv
deploy-arb-borrow-caps :;  forge script script/DeployBorrowCaps.s.sol:DeployArbitrumCaps --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ARBICAN_API_KEY} --verify -vvvv

# deploy borrow/supply caps proposal multichain:
deploy-caps-multi-proposal :; forge script script/DeployCapsMultiChainProposal.s.s.sol:DeployAllCaps --rpc-url mainnet --broadcast --legacy  --private-key ${PRIVATE_KEY} -vvvv
emit-caps-multi-proposal :; forge script script/DeployCapsMultiChainProposal.s.sol:EmitDeployAllCaps

# deploy jEUR/agEUR freezing payloads
deploy-op-ageur-freezing :; forge script script/DeployPolygonAGEURJEURfreeze.s.sol:DeployAGEURPayload --rpc-url polygon -vvvv
deploy-op-jeur-freezing :; forge script script/DeployPolygonAGEURJEURfreeze.s.sol:DeployJEURPayload --rpc-url polygon -vvvv

# deploy LDO Emission admin payloads
deploy-arb-ldo-emission-admin :; forge script script/DeployLDOEmissionAdminProposals.s.sol:DeployArbLDOEmissionAdmin --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM} --verify -vvvv
deploy-eth-ldo-emission-admin :;forge script script/DeployLDOEmissionAdminProposals.s.sol:DeployEthLDOEmissionAdmin --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify -vvvv
deploy-opt-ldo-emission-admin :; forge script script/DeployLDOEmissionAdminProposals.s.sol:DeployOptLDOEmissionAdmin --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM} --verify -vvvv

# Deploy L1 proposal polygon
deploy-l1-mai-proposal :; forge script script/DeployL1PolygonProposal.s.sol:DeployMai --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
deploy-l1-ageur-proposal :; forge script script/DeployL1PolygonProposal.s.sol:DeployAGEURFreeze --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
deploy-l1-jeur-proposal :; forge script script/DeployL1PolygonProposal.s.sol:DeployJEURFreeze --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv

# Deploy L1 proposal optimism
deploy-l1-op-proposal :; forge script script/DeployL1OptimismProposal.s.sol:DeployOp --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
emit-l1-op-calldata :; forge script script/DeployL1OptimismProposal.s.sol:EmitOp

git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
