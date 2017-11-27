# escape=`
FROM microsoft/windowsservercore:10.0.14393.1480
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package -Name microsoft-build-tools -RequiredVersion 15.0.26320.2 -Force; `
    Install-Package -Name netfx-4.6.1-devpack -RequiredVersion 4.6.01055.00 -Force; `
    Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force;

ENV NUGET_PATH="C:\Chocolatey\lib\NuGet.CommandLine.3.5.0\tools" `
    MSBUILD_PATH="C:\Windows\Microsoft.NET\Framework64\v4.0.30319"

RUN $env:PATH = $env:NUGET_PATH + ';' + $env:MSBUILD_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

ENTRYPOINT ["powershell"]