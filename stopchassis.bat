echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping consul.........."
docker-compose -f consul/docker-compose.yaml down

echo "Stopping vault.........."
docker-compose -f vaultroot/docker-compose.yml down
