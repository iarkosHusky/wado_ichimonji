FROM maven:3.8.5-openjdk-17 AS build
RUN mvn clean install -U -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.jar wado.jar

ENTRYPOINT ["java","-jar","wado.jar"]

