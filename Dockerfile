FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY lib/tzupdater.jar ./lib/tzupdater.jar
RUN mvn clean package -DskipTests


FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
COPY --from=build /app/lib/tzupdater.jar tzupdater.jar
RUN lib/tzupdater.jar -u -l https://www.iana.org/time-zones/repository/tzdata-latest.tar.gz  
ENTRYPOINT ["java","-jar","wado.jar"]
