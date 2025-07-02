# Use Maven with OpenJDK 11
FROM maven:3.9.6-eclipse-temurin-11 AS builder

# Set work directory
WORKDIR /app

# Copy Maven project files
COPY . .

# Build the project and skip tests
RUN mvn clean install -DskipTests

# ----------------------------------------------------------------------
# Runtime image: only needed if you want a separate smaller final image
# ----------------------------------------------------------------------
FROM eclipse-temurin:11-jdk

# Set work directory
WORKDIR /app

# Copy built artifacts from builder stage
COPY --from=builder /app .

# Default command to run tests (you can change this as needed)
CMD ["mvn", "test"]
