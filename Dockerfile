FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file and restore
COPY RealEstate.API/*.csproj ./RealEstate.API/
RUN dotnet restore RealEstate.API/RealEstate.API.csproj

# Copy everything else
COPY . .
RUN dotnet publish RealEstate.API/RealEstate.API.csproj -c Release -o /out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "RealEstate.API.dll"]

