FROM displax/msvc:2017-x64

LABEL maintainer="taraujo@displax.com"

RUN mkdir "C:\\Qt" && mkdir "C:\\temp" && mkdir "C:\\BuildTools\\Team Tools\\Performance Tools"
COPY qt-unified-windows-x86-3.2.1-2-online.exe "C:\\temp\\qt-unified-windows-x86-3.2.1-2-online.exe"
COPY qt-installer-noninteractive.qs "C:\\temp\\qt-installer-noninteractive.qs"
ENV CLANGPATH "C:\BuildTools\Team Tools\Performance Tools"
COPY clang-format.exe $CLANGPATH

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    "C:\\temp\\qt-unified-windows-x86-3.2.1-2-online.exe" --verbose --script "C:\\temp\\qt-installer-noninteractive.qs"

RUN choco install -y nodejs-lts curl
RUN choco install -y cmake --version 3.13.0

RUN icacls "C:\\Users\\jenkins\\workspace" /grant jenkins:(OI)(CI)F /T

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
$env:UCRTPATH = 'C:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0'; \
$env:QTDIR = 'C:\Qt\5.14.1\msvc2017_64'; \
$env:INCLUDE = 'C:\BuildTools\VC\Tools\MSVC\14.11.25503\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\shared;C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\um;C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\winrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\ucrt;'; \
$env:LIB = 'C:\BuildTools\VC\Tools\MSVC\14.11.25503\lib\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.17134.0\um\x64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.17134.0\ucrt\\x64;'; \
$env:LIBPATH = 'C:\Windows\MiCrosoft.NET\Framework\v4.0.30319;C:\Program Files (x86)\Windows Kits\8.1\References\CommonConfiguration\Neutral;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX4.7 Tools;'; \
$env:PATH = 'C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\;C:\Program Files (x86)\Windows Kits\8.1\Windows Performance Toolkit\;C:\BuildTools\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files (x86)\Microsoft SDKs\TypeScript\2.6;C:\BuildTools\MSBuild\15.0\Bin;C:\BuildTools\Common7\IDE;C:\BuildTools\VC\Tools\MSVC\14.11.25503\bin\Hostx64\x64;C:\BuildTools\Common7\Tools;C:\Windows\Microsoft.NET\Framework\v4.0.30319;C:\BuildTools\Common7\IDE\VC\vcpackages;C:\BuildTools\Team Tools\Performance Tools;C:\Program Files (x86)\Windows Kits\10\bin\x64;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX4.7 Tools;C:\Program Files (x86)\Windows Kits\10\bin\10.0.17134.0\x64;C:\Program Files (x86)\Microsoft SDKs\TypeScript\2.8;C:\Qt\5.14.1\msvc2017_64\bin;C:\Qt\Tools\QtCreator\bin;C:\Qt\Tools\QtInstallerFramework\3.0\bin;C:\Program Files\Git\bin;C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin;C:\Program Files\CMake\bin;' + $env:PATH; \
[Environment]::SetEnvironmentVariable('INCLUDE', $env:INCLUDE, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('UCRTPATH', $env:UCRTPATH, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('QTDIR', $env:QTDIR, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('LIB', $env:LIB, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('LIBPATH', $env:LIBPATH, [EnvironmentVariableTarget]::Machine); \
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine);
