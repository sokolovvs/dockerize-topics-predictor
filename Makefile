start:
		#bash ./installation.sh
		docker-compose up --build --remove-orphans -d
		make composer-i
stop:
		docker ps -aq --filter="name=dockerize-topics-predictor" | xargs -r docker stop
composer-i:
		docker ps -aq --filter="name=dockerize-topics-predictor_purchase-tps" | xargs -I'{}' docker exec -t '{}' bash -c "composer install --no-interaction --prefer-dist"