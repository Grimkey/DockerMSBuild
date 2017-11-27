# DockerMSBuild

In progress, working on make a docker file to use for building with msbuild based on the book _DOcker on Windows_

Example:

```#powershell
docker run -it --volume C:\github\DotNetInJenkins\DotNetJenkins:c:\src 'james/msbuild' powershell "msbuild /m c:\src\dotnetjenkins.sln"
```