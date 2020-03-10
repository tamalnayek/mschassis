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

SET baseoption=%1

IF /I "!baseoption!"=="help" (
   goto usage
)
IF /I "!baseoption!"=="services" (
	goto servicelisting
)


IF /I "!baseoption!"=="-s" (
	
	SET insallthisservice=%2
	
	SET swarmhost=%3
	
	IF /I "!swarmhost!"=="" (
			goto usage
	)
	SET insallthisservicevalid=N
	for /l %%n in (0,1,16) do ( 
		REM echo "!insallthisservice!" --- "!serviceslist[%%n]!"
		IF  /I !insallthisservice!==!serviceslist[%%n]! (
			SET insallthisservicevalid=Y
		)
	)
	IF /I "!insallthisservicevalid!"=="Y" (
			IF /I !insallthisservice!==configserver (
				set /p vaulttoken="Set Vault Token in env file (key : configserver.vault.token) and press any key to continue...."
			)
			echo Initializing swarm on !swarmhost!
			docker swarm init --advertise-addr=!swarmhost!
			echo Starting swarm network.........
			docker network create --scope=swarm --driver=overlay --attachable ms-chassis-nw-swarm
			echo Installing !insallthisservice! .....
			docker stack deploy --compose-file !insallthisservice!/docker-compose.yaml !insallthisservice!
			
	) ELSE (
		echo Invalid Service Name
		goto servicelisting  
	)
	goto end
)

IF /I "!baseoption!"=="all" (
	SET swarmhost=%2
	IF /I "!swarmhost!"=="" (
			goto usage
	)
   echo "All chassis services would be installed......"
) ELSE (
	IF /I "!baseoption!"=="" (
		goto usage
	)
	ELSE (
		SET swarmhost=!baseoption!
		SET baseoption=some
		echo "Individual services would need user input......"
	)
)


cls
set SERVICESFILE=chassisservices
echo Initializing swarm on !swarmhost!
docker swarm 	init --advertise-addr=!swarmhost!
echo "Starting docker network........."
docker network create --scope=swarm --driver=overlay --attachable ms-chassis-nw-swarm

for /F "usebackq tokens=* delims=" %%A in (%SERVICESFILE%) do (
    set the_line=%%A
	REM echo %%A
    for /F "tokens=1,2,3,4 delims=|"  %%1 in ("%%A") DO ( 
		  set _service_=%%1
		  set _climessage_=%%2
		  set _servicecommand_=%%3
		  set _active_=%%4
		  
		 REM echo %%1 , %%2, %%3, %%4
		  
			SET installservice=""
			SET servicecli="'
			IF /I NOT "!baseoption!"=="all" (
				set /p servicecli= %%2
				REM echo "post set servicecli !servicecli!"
			)

			IF /I "!servicecli!"=="y" (
				REM echo "servicecli y"
				SET installservice=y
				REM echo "intermediate 1 INSTALLCOINSUL !installservice!"
			)
			IF /I "!baseoption!"=="all" (
				REM echo "baseoption y"
				SET installservice=y
				REM echo "intermediate 2 INSTALLCOINSUL !installservice!"
			)
			REM echo "Final INSTALLCOINSUL !installservice!"

			IF /I "!installservice!"=="y" (
				echo "Starting %%1 >>>"
				call %%3
			)
	)
)

REM Install Cloud Config Service	
SET installservice=""
SET servicecli="'
IF /I NOT "!baseoption!"=="all" (
	set /p servicecli="Config Server(Y/N):"
	REM echo "post set servicecli !servicecli!"
)

IF /I "!servicecli!"=="y" (
	SET installservice=y
)
IF /I "!baseoption!"=="all" (
	SET installservice=y
)
IF /I "!installservice!"=="y" (
	
	set /p vaulttoken="Set Vault Token in env file (key : configserver.vault.token) and press any key to continue...."
	REM echo configserver.vault.token.cli=!vaulttoken! >> configserver/.env
	REM set configserver_vault_token_cli=!vaulttoken!
	docker stack deploy --compose-file configserver/docker-compose.yaml configserver
	REM sleep 10
	REM docker-compose -f configserver/docker-compose.yaml restart
	
)

REM Install Cloud Eureka	
SET installservice=""
SET servicecli="'
IF /I NOT "!baseoption!"=="all" (
	set /p servicecli="Eureka Service Discovery (Y/N):"
	REM echo "post set servicecli !servicecli!"
)

IF /I "!servicecli!"=="y" (
	SET installservice=y
)
IF /I "!baseoption!"=="all" (
	SET installservice=y
)
IF /I "!installservice!"=="y" (
		docker stack deploy --compose-file eureka/docker-compose.yaml eureka
)

REM Install Cloud Config Bus
REM SET installservice=""
REM SET servicecli="'
REM IF /I NOT "!baseoption!"=="all" (
REM 	set /p servicecli="Cloud Config Bus (Y/N):"
REM 	REM echo "post set servicecli !servicecli!"
REM )

REM IF /I "!servicecli!"=="y" (
REM 	SET installservice=y
REM )
REM IF /I "!baseoption!"=="all" (
REM 	SET installservice=y
REM )
REM IF /I "!installservice!"=="y" (
REM 		docker stack deploy --compose-file cloudconfigbus/docker-compose.yaml cloudconfigbus
REM )

REM Install Cloud Config Turbine
SET installservice=""
SET servicecli="'
IF /I NOT "!baseoption!"=="all" (
	set /p servicecli="Turbine (Y/N):"
	REM echo "post set servicecli !servicecli!"
)

IF /I "!servicecli!"=="y" (
	SET installservice=y
)
IF /I "!baseoption!"=="all" (
	SET installservice=y
)
IF /I "!installservice!"=="y" (
		docker stack deploy --compose-file turbine/docker-compose.yaml turbine
)

REM Install API GATEWAY
SET installservice=""
SET servicecli="'
IF /I NOT "!baseoption!"=="all" (
	set /p servicecli="API Gateway (Y/N):"
	REM echo "post set servicecli !servicecli!"
)

IF /I "!servicecli!"=="y" (
	SET installservice=y
)
IF /I "!baseoption!"=="all" (
	SET installservice=y
)
IF /I "!installservice!"=="y" (
		docker stack deploy --compose-file apigateway/docker-compose.yaml apigateway
)

goto end
					
:usage
echo Usage startchassis [OPTION] [DOCKER-HOST]
echo [OPTION]
echo help : Displays usage
echo all :  install all services. For config server,the installation would prompt for confirmation of vault token in .env file for config server
echo services : list all chassis services
echo -s servicename : install only provided service
echo.
echo [DOCKER-HOST]
echo host/ip of the docker machine where swarm needs to be iitialized.
goto endhelp

:servicelisting
echo Service Names :
   for /l %%n in (0,1,16) do ( 
		echo !serviceslist[%%n]!
	)
	echo To install a service use 
	echo startchassis -s servicename
    goto end



:end
echo.
echo STACKS
echo ---------------------------------------------------------------------------------
docker stack ls
echo.
echo SERVICES
echo ---------------------------------------------------------------------------------
docker service ls
echo.
echo *** END OF INSTALLATION ***

:endhelp


