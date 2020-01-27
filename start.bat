@echo:

SET baseoption=%1
REM echo %baseoption%
SET installservice=n
set servicecli=
IF /I NOT "%baseoption%"=="all" (
	set /p servicecli= "HashiCorp Consul(Y/N):" 
	REM echo %servicecli%
)

IF /I "%servicecli%"=="y" (
	REM echo "servicecli y"
	SET installservice=y
)
IF /I "%baseoption%"=="all" (
	REM echo "baseoption y"
	SET installservice=y
)
REM echo "Final INSTALLCOINSUL %installservice%"

IF /I "%installservice%"=="y" (
	echo "Starting consul.........."
	REM docker-compose -f consul/docker-compose.yaml up -d
)
