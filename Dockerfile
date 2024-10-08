FROM gradle:8.9.0-jdk22 AS build
COPY --chown=gradle:gradle . /home/gradle/src

WORKDIR /home/gradle/src

RUN chmod +x ./gradlew
RUN ./gradlew server:dist --build-cache

FROM eclipse-temurin:22-jre-alpine

COPY --from=build /home/gradle/src/server/build/libs/*.jar /app/server.jar

ENTRYPOINT ["java","-jar", "/app/server.jar"]


