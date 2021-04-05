#!/bin/bash

read -p "Please input secret: " secret

mkdir -p ./src/app-for-purchasing-service/config/jwt

openssl genrsa -passout pass:"$secret" -aes256 -out ./src/app-for-purchasing-service/config/jwt/private.pem 4096
openssl rsa -pubout -passin pass:$secret -in ./src/app-for-purchasing-service/config/jwt/private.pem -out ./src/app-for-purchasing-service/config/jwt/public.pem
echo "JWT_PASS=$secret" >>./src/app-for-purchasing-service/.env
