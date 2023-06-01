#!/bin/bash
json='["src/Test/test.md","src/Test/test2.md"]'
readarray -t json_array < <(jq -r '.[]' <<<"$json")
declare -p json_array
for i in "${json_array[@]}"
do
   npx aave-cli ipfs "$i" -u true
done
