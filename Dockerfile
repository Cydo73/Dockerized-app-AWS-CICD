FROM eclipse-temurin:17

WORKDIR /app

# Copy Maven wrapper and make it executable
COPY mvnw .
COPY .mvn .mvn
RUN chmod +x mvnw

# Copy pom.xml
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the application with verbose output
RUN ./mvnw clean package -DskipTests

# List what was built (for debugging)
RUN ls -la target/

# Find the exact JAR name and create a simpler name
RUN mv target/*.jar target/app.jar

EXPOSE 8080

# Use the explicit JAR name
CMD ["java", "-jar", "target/app.jar"]
