echo "Starting docker network........."
docker-compose -f network/docker-compose.yaml up -d

echo "Starting consul.........."
docker-compose -f consul/docker-compose.yaml up -d

echo "Starting vault.........."
docker-compose -f vaultroot/docker-compose.yml up -d
