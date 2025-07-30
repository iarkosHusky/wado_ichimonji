FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.jar wado.jar
RUN lib/tzupdater.jar -u -l https://www.iana.org/time-zones/repository/tzdata-latest.tar.gz  
ENTRYPOINT ["java","-jar","wado.jar"]

