FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /App

COPY ./DotNetCiCdDemo.sln ./
COPY ./DotNetCiCdDemo.Api/*.csproj ./DotNetCiCdDemo.Api/
COPY ./DotNetCiCdDemo.Test/*.csproj ./DotNetCiCdDemo.Test/

RUN dotnet restore DotNetCiCdDemo.sln

COPY . . 

RUN dotnet publish -o out -c Release ./DotNetCiCdDemo.Api/DotNetCiCdDemo.Api.csproj

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime

WORKDIR /App

COPY --from=build /App/out ./

ENTRYPOINT ["dotnet", "DotNetCiCdDemo.Api.dll"]
