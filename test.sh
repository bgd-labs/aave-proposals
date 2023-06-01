#!/bin/bash
readarray -t json_array < <(jq .[] "addedFiles.json")
declare -p json_array
for i in "${json_array[@]}"
do
  npx aave-cli ipfs "$i" -u true
done
