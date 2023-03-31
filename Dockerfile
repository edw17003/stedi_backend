FROM maven:3.6.3-adoptopenjdk-14 AS MAVEN_BUILD

WORKDIR /opt/stedi

COPY . ./

RUN mvn clean package

FROM adoptopenjdk/openjdk14

COPY --from=MAVEN_BUILD /opt/stedi/target/StepTimerWebsocket-1.0-SNAPSHOT.jar /stedi.jar

ENTRYPOINT ["java", "-jar", "/stedi.jar"]

EXPOSE 4567

# Start new content

# FROM mcr.microsoft.com/dotnet/aspnet:6.0
# EXPOSE 8080

# #------------------------------------------------------------------------------
# # Copy publishing artifacts.
# #------------------------------------------------------------------------------

# WORKDIR /app
# COPY CloudDemo.MvcCore/bin/Release/net6.0/publish/ /app/

# ENV ASPNETCORE_URLS=http://0.0.0.0:8080

# #------------------------------------------------------------------------------
# # Run application in Kestrel.
# #------------------------------------------------------------------------------

# ENTRYPOINT ["dotnet", "CloudDemo.MvcCore.dll"]