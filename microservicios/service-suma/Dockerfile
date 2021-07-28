# Build Time.
FROM gradle:jdk16-openj9 as build
WORKDIR /app
COPY . .
RUN gradle --no-daemon clean build 


# Run Time.
FROM adoptopenjdk/openjdk16:ubi
COPY build/libs/*.jar service.jar
CMD ["java", "-jar", "service.jar"]
WORKDIR /app
COPY --from=build /app/build/libs/*.jar service.jar
CMD ["java", "-jar", "/app/service.jar"]