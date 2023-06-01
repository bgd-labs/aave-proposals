#!/bin/bash
json_array=($(jq -r '.[]' "addedFiles.json"))
for i in ${!json_array[@]}
do
  npx aave-cli ipfs $(printf '%s\n' ${json_array[$i]}) -u true
done
