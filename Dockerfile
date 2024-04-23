FROM maven:3.9.6-eclipse-temurin-21-alpine AS stage-1
COPY ./ /app/spring-petclinic/
WORKDIR	/app
ENTRYPOINT ["mvn"]
CMD ["package"]
FROM alpine:latest as stage-2
COPY --from=stage-1 / /web-app-data
workdir /web-app-data
entrypoint ["ls", "-lah", "/web-app-data"]
FROM openjdk:23-jdk-slim
COPY --from=stage-2 /web-app-data/app/spring-petclinic/target/*.jar /app/spring-petclinic.jar
WORKDIR /app
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
