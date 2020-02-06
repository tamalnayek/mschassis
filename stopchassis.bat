echo off

setlocal enabledelayedexpansion
SET serviceslist[0]=apigateway
SET serviceslist[1]=cloudconfigbus 
SET serviceslist[2]=configserver
SET serviceslist[3]=consul
SET serviceslist[4]=elk
SET serviceslist[5]=eureka
SET serviceslist[6]=grafana 
SET serviceslist[7]=jenkins 
SET serviceslist[8]=kafka
SET serviceslist[9]=mongodb
SET serviceslist[10]=mysql
SET serviceslist[11]=prometheus
SET serviceslist[12]=rabbitmq
SET serviceslist[13]=redis
SET serviceslist[14]=turbine
SET serviceslist[15]=uaa
SET serviceslist[16]=vault
SET serviceslist[17]=zipkin

SET baseoption=%1

IF /I "!baseoption!"=="help" (
   goto usage
)
IF /I "!baseoption!"=="services" (
	goto servicelisting
)

IF /I "!baseoption!"=="-s" (
	SET uninsallthisservice=%2
	SET uninsallthisservicevalid=N
	for /l %%n in (0,1,17) do ( 
		REM echo "!uninsallthisservice!" --- "!serviceslist[%%n]!"
		IF  /I !uninsallthisservice!==!serviceslist[%%n]! (
			SET uninsallthisservicevalid=Y
		)
	)
	IF /I "!uninsallthisservicevalid!"=="Y" (

			echo Stopping !uninsallthisservice! .....
			docker-compose -f !uninsallthisservice!/docker-compose.yaml down
	) ELSE (
		echo Invalid Service Name
		goto servicelisting  
	)
	goto end
)

IF /I NOT "!baseoption!"=="" (
	goto usage
)

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
REM docker-compose -f vault/docker-compose.yaml down

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

goto end
					
:usage
echo Usage stopchassis [OPTION]
echo OPTION
echo help : Displays usage
echo none : i.e. pressing enter after startchassis command would attemp to stop and remove all services
echo services : list all chassis services
echo -s servicename : removes only provided service
goto end

:servicelisting
echo Service Names :
   for /l %%n in (0,1,17) do ( 
		echo !serviceslist[%%n]!
	)
	echo To uninstall a service use 
	echo stopchassis -s servicename
    goto end



:end
echo *** END OF UNINSTALLATION ***
