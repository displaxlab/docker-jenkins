FROM microsoft/dotnet-framework:4.7.1

LABEL maintainer="taraujo@displax.com"

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
 "(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))) >$null 2>&1" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

RUN choco feature enable -n allowGlobalConfirmation
RUN choco install git --params='/NoShellIntegration'
RUN choco install nuget.commandline

ENV JAVA_HOME=c:\\jre1.8.0_91 JENKINS_HOME=c:\\Users\\jenkins

RUN net user /ADD jenkins Qwerty123!
RUN net localgroup administrators jenkins /AD
RUN mkdir C:\\Users\\jenkins\\workspace

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    (new-object System.Net.WebClient).Downloadfile('http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185', 'C:\jre-8u91-windows-x64.exe')

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    start-process -filepath C:\\jre-8u91-windows-x64.exe -passthru -wait -argumentlist "/s,INSTALLDIR=$env:JAVA_HOME,/L,install64.log"

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    del C:\jre-8u91-windows-x64.exe

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $env:PATH = $env:JAVA_HOME + '\\bin;' + $env:PATH; \
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine);

ARG BASE_URL
ARG SECRET

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
(New-Object System.Net.WebClient).DownloadFile('{0}/jnlpJars/slave.jar' -f $env:BASE_URL, 'slave.jar');

ENTRYPOINT ["java.exe", "-jar", ".\\slave.jar"]
