start:
		docker-compose up --build --remove-orphans -d
stop:
		docker ps -aq --filter="name=dockerizetopicspredictor" | xargs -r docker stop