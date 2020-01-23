echo off
echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping zipkin.........."
docker-compose -f zipkin/docker-compose.yaml down

echo "Stopping jenkins.........."
docker-compose -f jenkins/docker-compose.yaml down

echo "Stopping prometheus.........."
docker-compose -f prometheus/docker-compose.yaml down

echo "Stopping mongo DB.........."
docker-compose -f mongodb/docker-compose.yaml down

echo "Stopping vault.........."
docker-compose -f vaultroot/docker-compose.yaml down



echo "Stopping chassis network.........."
docker network rm ms-chassis-nw

echo "Prunning all networks.........."
docker network prune --force

echo "Prunning all containers.........."
docker container prune --force

echo "*** CHASSIS REMOVED ***"
