
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:5235

#Exponer el puerto que usara la aplicacion
EXPOSE 5235

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar el resto del código
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
# COPY --from=build /app/publish .
COPY --from=build /app .

ENTRYPOINT ["dotnet", "apiCambiosMoneda.Presentacion.dll"]
