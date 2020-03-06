@echo off

setlocal enabledelayedexpansion
SET serviceslist[0]=apigateway
REM SET serviceslist[1]=cloudconfigbus
SET serviceslist[1]=configserver
SET serviceslist[2]=consul
SET serviceslist[3]=elk
SET serviceslist[4]=eureka
SET serviceslist[5]=grafana
SET serviceslist[6]=jenkins
SET serviceslist[7]=kafka
SET serviceslist[8]=mongodb
SET serviceslist[9]=mysql
SET serviceslist[10]=prometheus
SET serviceslist[11]=rabbitmq
SET serviceslist[12]=redis
SET serviceslist[13]=turbine
SET serviceslist[14]=uaa
SET serviceslist[15]=vault
SET serviceslist[16]=zipkin
SET serviceslist[17]=jaeger

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

for /l %%n in (0,1,17) do ( 
		echo Stopping !serviceslist[%%n]!
		docker-compose -f !serviceslist[%%n]!/docker-compose.yaml down
)

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
goto endhelp

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

:endhelp


