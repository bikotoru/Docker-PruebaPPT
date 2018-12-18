FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["Demoppt2/Demoppt2.csproj", "Demoppt2/"]
RUN dotnet restore "Demoppt2/Demoppt2.csproj"
COPY . .
WORKDIR "/src/Demoppt2"
RUN dotnet build "Demoppt2.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Demoppt2.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Demoppt2.dll"]