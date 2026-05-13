# Build Stage
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /workspace
# Copy pom.xml and source code
COPY app/pom.xml .
COPY app/src ./src
# Build application
RUN mvn clean package -DskipTests

# Run Stage
FROM eclipse-temurin:17-jre-alpine
# Add non-root user for security (Least Privilege)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

WORKDIR /app
COPY --from=build /workspace/target/fintech-app-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
