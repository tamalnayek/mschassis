echo "Starting docker network........."
docker-compose -f network/docker-compose.yaml up -d

echo "Starting consul.........."
docker-compose -f consul/docker-compose.yaml up -d
