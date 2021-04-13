start:
		bash ./installation.sh
		cd ./src/tps && bash ./pre-start-check.sh && cd .
		docker-compose up --build --remove-orphans -d #--scale messenger-async=2
		make composer-i
		make db-migrate
stop:
		docker ps -aq --filter="name=dockerize-tps-dev" | xargs -r docker stop
# Purchase TPS
composer-i:
		docker ps -aq --filter="name=dockerize-tps-dev_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "composer install --no-interaction --prefer-dist"
clear-cache:
		docker ps -aq --filter="name=dockerize-tps-dev_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console cache:clear"
jwt-keys:
		bash ./generate-jwt-secrets.sh
messenger-async:
		docker ps -aq --filter="name=dockerize-tps-dev_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console messenger:consume async -vv"
db-migrate:
		docker ps -aq --filter="name=dockerize-tps-dev_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console doctrine:migrations:migrate --no-interaction"
db-mig-rollb-prev:
		docker ps -aq --filter="name=dockerize-tps-dev_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "php bin/console doctrine:migrations:migrate prev --no-interaction"
