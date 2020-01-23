echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping vault.........."
docker-compose -f vaultroot/docker-compose.yaml down

call echo "Stopping zipkin.........."
docker-compose -f zipkin/docker-compose.yaml down
