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


# Deploy L1 proposal polygon
deploy-l1-mai-proposal :; forge script script/DeployL1PolygonProposal.s.sol:DeployMai --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv

# Deploy L1 proposal optimism
deploy-l1-op-proposal :; forge script script/DeployL1OptimismProposal.s.sol:DeployOp --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
emit-l1-op-calldata :; forge script script/DeployL1OptimismProposal.s.sol:EmitOp
