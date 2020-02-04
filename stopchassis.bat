echo off
echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping zipkin.........."
docker-compose -f zipkin/docker-compose.yaml down

echo "Stopping jenkins.........."
docker-compose -f jenkins/docker-compose.yaml down

echo "Stopping prometheus.........."
docker-compose -f prometheus/docker-compose.yaml down

echo "Stopping grafana.........."
docker-compose -f grafana/docker-compose.yaml down

echo "Stopping mongo DB.........."
docker-compose -f mongodb/docker-compose.yaml down

echo "Stopping mySQL DB.........."
docker-compose -f mysql/docker-compose.yaml down

echo "Stopping Redis.........."
docker-compose -f redis/docker-compose.yaml down

echo "Stopping vault.........."
REM docker-compose -f vaultroot/docker-compose.yaml down

echo "Stopping Rabbit MQ .........."
docker-compose -f rabbitmq/docker-compose.yaml down

echo "Stopping Kafka ......"
docker-compose -f kafka/docker-compose.yaml down

Rem echo "Stopping Cloud Foundary UAA .........."
Rem docker container stop uaa
Rem docker container rm uaa

echo "Stopping Config Server .........."
docker-compose -f configserver/docker-compose.yaml down

echo "Stopping Eureka Server .........."
docker-compose -f eureka/docker-compose.yaml down

echo "Stopping cloud bus .........."
docker-compose -f cloudconfigbus/docker-compose.yaml down

echo "Stopping Turbine .........."
docker-compose -f turbine/docker-compose.yaml down

echo "Stopping API Gateway .........."
docker-compose -f apigateway/docker-compose.yaml down

echo "Prunning all containers.........."
docker container prune --force


echo "Stopping chassis network.........."
docker network rm ms-chassis-nw

echo "Prunning all networks.........."
docker network prune --force



echo "*** CHASSIS REMOVED ***"
