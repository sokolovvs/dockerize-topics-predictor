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

rootPath=$(pwd)
pathToSrc="${rootPath}/src"

echo "trying to update dockerize project"
git pull

echo "trying to copy .env from dockerize project"
updateDotEnv "$rootPath/.env"

# INSTALL TPS
pathToTps="${rootPath}/src/tps"

if [[ ! -d "$pathToTps" ]]; then
  echo "trying to clone the sokolovvs/tps repository"
  cd "$pathToSrc" && git clone git@github.com:sokolovvs/tps.git
fi

echo "trying to update the sokolovvs/tps repository"
cd "$pathToTps" && git pull

echo "trying to copy .env from tps project"
updateDotEnv "$pathToTps/.env"

# INSTALL app-for-purchasing-service
pathToPs="${rootPath}/src/app-for-purchasing-service"

if [[ ! -d "$pathToPs" ]]; then
  echo "trying to clone the sokolovvs/app-for-purchasing-service repository"
  cd "$pathToSrc" && git clone git@github.com:sokolovvs/app-for-purchasing-service.git
fi

echo "trying to update the sokolovvs/app-for-purchasing-service repository"
cd "$pathToPs" && git pull

echo "trying to copy .env from app-for-purchasing-service project"
updateDotEnv "$pathToPs/.env"
