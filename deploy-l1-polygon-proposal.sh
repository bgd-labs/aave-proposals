# To load the variables in the .env file
source ./.env

if [[ $L2_PAYLOAD_ADDRESS == "" ]]
then
  echo "ERROR: L2_PAYLOAD_ADDRESS must be set"
  exit 1
fi

if [[ $IPFS_HASH == "" ]]
then
  echo "ERROR: IPFS_HASH must be set"
  exit 1
fi

if [[ $ETHERSCAN_API_KEY == "" ]]
then
  echo "ERROR: ETHERSCAN_API_KEY must be set"
  exit 1
fi

if [[ $RPC_URL == "" ]]
then
  echo "ERROR: RPC_URL must be set"
  exit 1
fi

params=""
if [[ $MNEMONIC_INDEX != "" && $LEDGER_SENDER != "" ]]
then
  params="--ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER}"
elif [[ $PRIVATE_KEY != "" ]]
then
  params="--private-key $PRIVATE_KEY"
fi

if [[ $params == "" ]]
then
  echo "ERROR: You net to setup ledger or private key"
  exit 1
fi

# To deploy and verify our contract
# legacy because
{
  forge script script/$1.s.sol:$1 --rpc-url $RPC_URL --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv --chain-id 1 --legacy $params
} || {
  echo "waiting 1min as the txn might not yet be on the explorer"
  sleep 1m
  forge script script/$1.s.sol:$1 --rpc-url $RPC_URL --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv --chain-id 1 --legacy $params
} || {
  echo "waiting another 5min as the verification might still be pending"
  sleep 5m
  forge script script/$1.s.sol:$1 --rpc-url $RPC_URL --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv --chain-id 1 --legacy $params
}
