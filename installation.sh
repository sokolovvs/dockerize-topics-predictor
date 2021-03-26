#!/bin/bash

rootPath=`pwd`
pathToSrc="${rootPath}/src"

echo "try update dockerize project"
git pull

echo "try copy .env from dockerize project"
cp .env.example .env

# INSTALL TPS
pathToTps="${rootPath}/src/tps"

if [[ ! -d "$pathToTps" ]]
then
  echo "try clone the sokolovvs/tps repository"
  cd "$pathToSrc" && git clone git@github.com:sokolovvs/tps.git
fi

echo "try update the sokolovvs/tps repository"
cd "$pathToTps" && git pull

echo "try copy .env from tps project"
cd "$pathToTps" && cp .env.example .env



# INSTALL app-for-purchasing-service
pathToPs="${rootPath}/src/app-for-purchasing-service"

if [[ ! -d "$pathToPs" ]]
then
  echo "try clone the sokolovvs/app-for-purchasing-service repository"
  cd "$pathToSrc" && git clone git@github.com:sokolovvs/app-for-purchasing-service.git
fi

echo "try update the sokolovvs/app-for-purchasing-service repository"
cd "$pathToPs" && git pull

echo "try copy .env from app-for-purchasing-service project"
cd "$pathToPs" && cp .env.example .env
