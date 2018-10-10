FROM displax/msvc:2015-x86

LABEL maintainer="taraujo@displax.com"

RUN mkdir "C:\\Qt" && mkdir "C:\\BuildTools\\Team Tools\\Performance Tools"
COPY qt-unified-windows-x86-3.0.4-online.exe "C:\\temp\\qt-unified-windows-x86-3.0.4-online.exe"
COPY qt-installer-noninteractive.qs "C:\\temp\\qt-installer-noninteractive.qs"
COPY clang-format.exe "C:\\BuildTools\\Team Tools\\Performance Tools\\clang-format.exe"

RUN powershell -Command \
    "C:\\temp\\qt-unified-windows-x86-3.0.4-online.exe" --verbose --script "C:\\temp\\qt-installer-noninteractive.qs"

RUN choco install -y nodejs-lts curl

RUN icacls "C:\\Users\\jenkins\\workspace" /grant jenkins:(OI)(CI)F /T

# Prepare environment to jenkins builds
RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
$env:UCRTPATH = 'C:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0'; \
$env:QTDIR = 'C:\Qt\5.10.1\msvc2015'; \
$env:INCLUDE = 'C:\BuildTools\VC\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\shared;C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\um;C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\winrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\ucrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\cppwinrt\winrt'; \
$env:LIB = 'C:\BuildTools\VC\lib;C:\Program Files (x86)\Windows Kits\10\lib\10.0.15063.0\um\x86;C:\Program Files (x86)\Windows Kits\10\lib\10.0.15063.0\ucrt\x86'; \
$env:LIBPATH = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319;C:\Program Files (x86)\Windows Kits\8.1\References\CommonConfiguration\Neutral;C:\Program Files (x86)\Microsoft SDKs\windows\v10.0A\bin\NETFX4.6.1 Tools'; \
$env:PATH = 'C:\BuildTools\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files (x86)\Microsoft SDKs\TypeScript\1.8;C:\Program Files (x86)\MSBuild\14.0\Bin;C:\BuildTools\Common7\IDE;C:\BuildTools\VC\bin;C:\BuildTools\Common7\Tools;C:\Windows\Microsoft.NET\Framework\v4.0.30319;C:\BuildTools\VC\vcpackages;C:\BuildTools\Team Tools\Performance Tools;C:\Program Files (x86)\Windows Kits\10\bin\x86;C:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0\x86;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin;C:\Program Files\nodejs;C:\Windows\System32;C:\Windows;C:\Windows\System32\wbem;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Qt\5.10.1\msvc2015\bin;C:\Qt\Tools\QtCreator\bin;C:\Qt\Tools\QtInstallerFramework\3.0\bin;' + $env:PATH; \
[Environment]::SetEnvironmentVariable('INCLUDE', $env:INCLUDE, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('UCRTPATH', $env:UCRTPATH, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('QTDIR', $env:QTDIR, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('LIB', $env:LIB, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('LIBPATH', $env:LIBPATH, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine);
