@echo off

rem Remove surrounding quotes from the first parameter
rem @param Installation directory
set str=%~1

rem Check Home parameter
if "%str%" == "" goto missingHome
set PJB_HOME=%str%

echo Installation de PHP/Java Bridge en cours...
"%PJB_HOME%\bin\PhpJavaBridge.exe" //IS --DisplayName="PHP-Java Bridge" --Description="Daemon that allows a PHP script to execute Java code" --StartClass=php.java.bridge.JavaBridge --Classpath="%PJB_HOME%\lib\*" --LogPath="%PJB_HOME%\log" --StdOutput=auto --StdError=auto --StartParams="INET:9080;3" --Startup=auto --DependsOn="Tcpip" --StartMode=jvm ++JvmOptions=-Djava.awt.headless=true ++JvmOptions=-Dphp.java.bridge.base="%PJB_HOME%\php\"

echo Démarrage du service
sc Start PhpJavaBridge

EXIT /B

:missingHome
echo Vous devez indiquer le répertoire d'installation

EXIT /B