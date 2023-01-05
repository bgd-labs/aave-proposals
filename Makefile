# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes

test   :; forge test -vvv

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

# Deploy L1 proposal polygon
deploy-l1-mai-proposal :; forge script script/DeployL1PolygonProposal.s.sol:DeployMai --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv

# Deploy L1 proposal optimism
deploy-l1-op-proposal :; forge script script/DeployL1OptimismProposal.s.sol:DeployOp --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
emit-l1-op-calldata :; forge script script/DeployL1OptimismProposal.s.sol:EmitOp
