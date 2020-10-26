FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY Layers/Presentation/Presentation.API/*.csproj ./Layers/Presentation/Presentation.API/
COPY Layers/Infrastructure/Infrastructure.API/*.csproj ./Layers/Infrastructure/Infrastructure.API/
COPY Layers/Application/Application.API/*.csproj ./Layers/Application/Application.API/
COPY Layers/Domain/Domain.API/*.csproj ./Layers/Domain/Domain.API/
RUN dotnet restore

# copy everything else and build app
COPY Layers/Presentation/Presentation.API/. ./Layers/Presentation/Presentation.API/
WORKDIR /source/Layers/Presentation/Presentation.API
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 80/tcp
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "WebChat.Presentation.API.dll"]
