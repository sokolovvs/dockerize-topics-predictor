start:
		bash ./installation.sh
		docker-compose up --build --remove-orphans -d #--scale messenger-async=2
		make composer-i
		make db-migrate
stop:
		docker ps -aq --filter="name=dockerize-topics-predictor" | xargs -r docker stop
# Purchase TPS
composer-i:
		docker ps -aq --filter="name=dockerize-topics-predictor_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "composer install --no-interaction --prefer-dist"
clear-cache:
		docker ps -aq --filter="name=dockerize-topics-predictor_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console cache:clear"
jwt-keys:
		mkdir -p ./src/app-for-purchasing-service/config/jwt
		openssl genrsa -out ./src/app-for-purchasing-service/config/jwt/private.pem -aes256 4096
		openssl rsa -pubout -in ./src/app-for-purchasing-service/config/jwt/private.pem -out ./src/app-for-purchasing-service/config/jwt/public.pem
messenger-async:
		docker ps -aq --filter="name=dockerize-topics-predictor_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console messenger:consume async -vv"
db-migrate:
		docker ps -aq --filter="name=dockerize-topics-predictor_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console doctrine:migrations:migrate --no-interaction"
db-mig-rollb-prev:
		docker ps -aq --filter="name=dockerize-topics-predictor_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console doctrine:migrations:migrate prev --no-interaction"
