# ---------- Stage 1: Build the JAR ----------
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

# Copy the entire project
COPY . .

# Build the application and skip tests
RUN mvn clean package -DskipTests=true

# ---------- Stage 2: Run the app ----------
FROM openjdk:17-alpine

WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/ExpensesTracker-0.0.1-SNAPSHOT.jar /app/ExpensesTracker.jar

EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/ExpensesTracker.jar"]
