# To load the variables in the .env file
source ./.env

# To deploy and verify our contract
# legacy because
{
  forge script script/$1.s.sol:$1 --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv --chain-id 137 --legacy
} || {
  echo "waiting 1min as the txn might not yet be on the explorer"
  sleep 1m
  forge script script/$1.s.sol:$1 --rpc-url $RPC_URL --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv --chain-id 137 --legacy
} || {
  echo "waiting another 5min as the verification might still be pending"
  sleep 5m
  forge script script/$1.s.sol:$1 --rpc-url $RPC_URL --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv --chain-id 137 --legacy
}
