@echo off
cls
setlocal enabledelayedexpansion

SET baseoption=%1
echo "Starting docker network........."
docker network create ms-chassis-nw

IF /I "!baseoption!"=="all" (
   echo "All chassis services would be installed......"
) ELSE (
	SET baseoption=some
	echo "Individual services would need user input......"
)
set SERVICESFILE=chassisservices
REM call consul/start %baseoption%
REM call zipkin/start %baseoption%


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
	docker-compose -f configserver/docker-compose.yaml up -d
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
		docker-compose -f eureka/docker-compose.yaml up -d
)

REM Install Cloud Config Bud
SET installservice=""
SET servicecli="'
IF /I NOT "!baseoption!"=="all" (
	set /p servicecli="Cloud Config Bus (Y/N):"
	REM echo "post set servicecli !servicecli!"
)

IF /I "!servicecli!"=="y" (
	SET installservice=y
)
IF /I "!baseoption!"=="all" (
	SET installservice=y
)
IF /I "!installservice!"=="y" (
		docker-compose -f cloudconfigbus/docker-compose.yaml up -d
)

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
		docker-compose -f turbine/docker-compose.yaml up -d
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
		docker-compose -f apigateway/docker-compose.yaml up -d
)
					


@echo:
echo "*** CHASSIS STARTED ***"
