# escape=`
FROM microsoft/windowsservercore:1709
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
#    Install-Package -Name microsoft-build-tools -RequiredVersion 15.0.26320.2 -Force; `
#    Install-Package -Name netfx-4.6.1-devpack -RequiredVersion 4.6.01055.00 -Force; `
#    Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force;

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN choco install dotnet4.6.1 -y
RUN choco install visualstudio2017-installer -y
RUN choco install chocolatey-visualstudio.extension -y
RUN choco install visualstudio2017buildtools -y
RUN choco install visualstudio2017-workload-webbuildtools --package-parameters "--includeOptional" -y
RUN choco install nuget.commandline -y

ENV NUGET_PATH="C:\Chocolatey\lib\NuGet.CommandLine.3.5.0\tools" `
    MSBUILD_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\amd64"
    #MSBUILD_PATH="C:\Windows\Microsoft.NET\Framework64\v4.0.30319"

RUN $env:PATH = $env:NUGET_PATH + ';' + $env:MSBUILD_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

ENTRYPOINT ["powershell"]