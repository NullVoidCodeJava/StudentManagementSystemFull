# Use an official Maven image as a parent image
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Build the application and skip tests
RUN mvn clean package -DskipTests

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar studentsystembackend.jar

# Create a directory for the application properties
RUN mkdir -p /app/config

# Create application.properties file with database configuration
RUN echo "spring.datasource.url=jdbc:mysql://mysql-db:3306/fullstack?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true" > /app/config/application.properties
RUN echo "spring.datasource.username=root" >> /app/config/application.properties
RUN echo "spring.datasource.password=root" >> /app/config/application.properties
RUN echo "spring.jpa.hibernate.ddl-auto=update" >> /app/config/application.properties
RUN echo "spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect" >> /app/config/application.properties
RUN echo "spring.datasource.initialization-mode=always" >> /app/config/application.properties
RUN echo "spring.jpa.show-sql=true" >> /app/config/application.properties

# Expose the port the app runs on
EXPOSE 8080

# Run the jar file with the custom application.properties
ENTRYPOINT ["java", "-jar", "/app/studentsystembackend.jar", "--spring.config.location=file:/app/config/application.properties"]