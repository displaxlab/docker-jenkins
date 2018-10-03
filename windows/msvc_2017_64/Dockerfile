FROM displax/windows-server-jenkins

RUN choco install netfx-4.6.1-devpack windows-sdk-8.1 windows-sdk-10.1

ENV TEST_CONTAINER=1 \
    VS_CHANNEL_URI=https://aka.ms/vs/15/release/799c44140/channel \
    VS_BUILDTOOLS_URI=https://aka.ms/vs/15/release/799c44140/vs_buildtools.exe \
    VS_BUILDTOOLS_SHA256=FA29EB83297AECADB0C4CD41E54512C953164E64EEDD9FB9D3BF9BD70C9A2D29

# Download log collection utility
RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    $VerbosePreference = 'Continue'; \
    Invoke-WebRequest -Uri https://aka.ms/vscollect.exe -OutFile C:\collect.exe

# Download vs_buildtools.exe
RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    $VerbosePreference = 'Continue'; \
    Invoke-WebRequest -Uri $env:VS_BUILDTOOLS_URI -OutFile C:\vs_buildtools.exe; \
    if ((Get-FileHash -Path C:\vs_buildtools.exe -Algorithm SHA256).Hash -ne $env:VS_BUILDTOOLS_SHA256) { throw 'Download hash does not match' }

# Install Visual Studio Build Tools
RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $ErrorActionPreference = 'Stop'; \
    $VerbosePreference = 'Continue'; \
    $p = Start-Process -Wait -PassThru -FilePath C:\vs_buildtools.exe -ArgumentList '--quiet --nocache --wait --installPath C:\BuildTools'; \
    if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $ErrorActionPreference = 'Stop'; \
    $VerbosePreference = 'Continue'; \
    $p = Start-Process -Wait -PassThru -FilePath C:\vs_buildtools.exe -ArgumentList 'modify --quiet --nocache --wait --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.MSBuildTools'; \
    if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $ErrorActionPreference = 'Stop'; \
    $VerbosePreference = 'Continue'; \
    $p = Start-Process -Wait -PassThru -FilePath C:\vs_buildtools.exe -ArgumentList 'modify --quiet --nocache --wait --installPath C:\BuildTools --add Microsoft.VisualStudio.Component.Static.Analysis.Tools'; \
    if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }

RUN @powershell -NoProfile -ExecutionPolicy unrestricted -Command \
    $ErrorActionPreference = 'Stop'; \
    $VerbosePreference = 'Continue'; \
    $p = Start-Process -Wait -PassThru -FilePath C:\vs_buildtools.exe -ArgumentList 'modify --quiet --nocache --wait --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.VCTools'; \
    if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }
