FROM maven:3.8.6-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY lib/tzupdater.jar ./lib/tzupdater.jar
RUN mvn clean package -DskipTests

FROM openjdk:17.0.8-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
COPY --from=builder /app/lib/tzupdater.jar tzupdater.jar
RUN java -jar tzupdater.jar -u -l https://www.iana.org/time-zones/repository/tzdata-latest.tar.gz
CMD ["java", "-jar", "app.jar"]