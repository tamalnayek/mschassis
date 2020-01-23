echo "Starting docker network........."
call docker-compose -f network/docker-compose.yaml up -d

call echo "Starting consul.........."
docker-compose -f consul/docker-compose.yaml up -d

call echo "Starting vault.........."
docker-compose -f vaultroot/docker-compose.yaml up -d

call echo "Starting zipkin.........."
docker-compose -f zipkin/docker-compose.yaml up -d
