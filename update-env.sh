#!/bin/bash

# read dot env file to hashmap $tmpHash
# param $1 - path to dot env file
function readDotEnvIntoTmpHash() {
  local pathToDotEnv=$1

  for line in $(egrep -v '^#' $pathToDotEnv | xargs); do
    IFS="=" read -ra STR_ARRAY <<<"$line"
    local k=${STR_ARRAY[0]}
    local v=${STR_ARRAY[1]}
    tmpHash["$k"]="$v"
  done
}

# cp env.example .env with saving defined values from .env
# param $1 - path to dot env file
function updateDotEnv() {
  declare -A tmpHash

  pathToEnv=$1
  readDotEnvIntoTmpHash "$pathToEnv.example"
  readDotEnvIntoTmpHash "$pathToEnv"
  writeDotEnv "$pathToEnv"

  unset tmpHash
}

# write hashmap $tmpHash to dot env file
# param $1 - path to dot env file
function writeDotEnv() {
  pathToEnv=$1

  cat /dev/null >"$pathToEnv"

  for k in "${!tmpHash[@]}"; do
    echo "$k=${tmpHash[$k]}" >>"$pathToEnv"
  done
}
