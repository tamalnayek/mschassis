@echo off
cls
setlocal enabledelayedexpansion

SET baseoption=%1
echo "Starting docker network........."
REM docker network create ms-chassis-nw

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


@echo:
echo "*** CHASSIS STARTED ***"
