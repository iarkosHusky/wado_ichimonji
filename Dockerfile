FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY lib/tzupdater.jar ./lib/tzupdater.jar
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.jar wado.jar

ENTRYPOINT ["java","-jar","wado.jar"]

