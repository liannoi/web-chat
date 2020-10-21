FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY api/*.csproj ./api/
COPY infrastructure/*.csproj ./infrastructure/
COPY core/application/*.csproj ./core/application/
COPY core/domain/*.csproj ./core/domain/
RUN dotnet restore

# copy everything else and build app
COPY api/. ./api/
WORKDIR /source/api
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 80/tcp
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "WebChat.Api.dll"]
