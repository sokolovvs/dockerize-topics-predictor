#!/bin/bash

source ./update-env.sh

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
