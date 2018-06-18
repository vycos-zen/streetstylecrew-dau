FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
COPY package.json ./
RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash -
RUN apt-get install -y build-essential nodejs
RUN npm install -g @angular/cli@1.6.3
RUN npm install
RUN dotnet restore

# copy everything else and build app
COPY . ./
RUN dotnet publish -c Release -o out


FROM microsoft//aspnetcore:2.0 AS runtime
WORKDIR /app
COPY --from=build /appstreetstylecrew-dua/out ./
ENTRYPOINT ["dotnet", "streetstylecrew-dua.dll"]