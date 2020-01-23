echo off
echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping zipkin.........."
docker-compose -f zipkin/docker-compose.yaml down

echo "Stopping jenkins.........."
docker-compose -f jenkins/docker-compose.yaml down

echo "Stopping prometheus.........."
docker-compose -f prometheus/docker-compose.yaml down

echo "Starting grafana.........."
docker-compose -f grafana/docker-compose.yaml down

echo "Stopping mongo DB.........."
docker-compose -f mongodb/docker-compose.yaml down

echo "Stopping mySQL DB.........."
docker-compose -f mysql/docker-compose.yaml down

echo "Stopping vault.........."
docker-compose -f vaultroot/docker-compose.yaml down

echo "Starting Rabbit MQ .........."
docker-compose -f rabbitmq/docker-compose.yaml down

Rem echo "Stopping Cloud Foundary UAA .........."
Rem docker container stop uaa
Rem docker container rm uaa


echo "Prunning all containers.........."
docker container prune --force


echo "Stopping chassis network.........."
docker network rm ms-chassis-nw

echo "Prunning all networks.........."
docker network prune --force



echo "*** CHASSIS REMOVED ***"
