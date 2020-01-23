echo off

echo "Starting docker network........."
docker network create ms-chassis-nw

echo "Starting consul.........."
docker-compose -f consul/docker-compose.yaml up -d

echo "Starting zipkin.........."
docker-compose -f zipkin/docker-compose.yaml up -d

echo "Starting jenkins.........."
docker-compose -f jenkins/docker-compose.yaml up -d

echo "Starting prometheus.........."
docker-compose -f prometheus/docker-compose.yaml up -d

echo "Starting grafana.........."
docker-compose -f grafana/docker-compose.yaml up -d

echo "Starting mongo DB.........."
docker-compose -f mongodb/docker-compose.yaml up -d

echo "Starting mySQL DB.........."
docker-compose -f mysql/docker-compose.yaml up -d

echo "Starting vault.........."
docker-compose -f vaultroot/docker-compose.yaml up -d


echo "Starting Rabbit MQ .........."
docker-compose -f rabbitmq/docker-compose.yaml up -d


echo "*** CHASSIS STARTED ***"
