FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /app
COPY src .
COPY pom.xml .
RUN mvn -f /app/pom.xml clean install package

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/demo-0.0.1-SNAPSHOT.jar"]
