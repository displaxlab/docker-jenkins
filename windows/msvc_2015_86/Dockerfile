FROM displax/windows-server-jenkins

RUN mkdir "C:\\BuildTools"

COPY Msvc2015AdminDeployment.xml C:\\temp\\Msvc2015AdminDeployment.xml
COPY vs_community.exe C:\\temp\\vs_community.exe

RUN  C:\temp\vs_community.exe /NoRestart /Passive /Q /S /AdminFile C:\temp\Msvc2015AdminDeployment.xml || IF "%ERRORLEVEL%"=="3010" EXIT 0

RUN choco install netfx-4.6.1-devpack windows-sdk-8.1 windows-sdk-10.1
RUN choco install microsoft-build-tools --version 14.0.25420.1
