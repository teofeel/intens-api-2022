# First build stage
FROM maven:3.9-eclipse-temurin-17 AS builder

# Creating directorium builder
WORKDIR /builder

# Copy all maven files 
COPY pom.xml .
COPY src ./src

# Build jar inside docker
RUN mvn clean package -DskipTests 

#Extract layers
RUN java -Djarmode=layertools -jar target/*.jar extract --destination extracted


# Second runtime stage
FROM eclipse-temurin:8-jre-alpine

# Now we are creatind directorium app where the actual app will be
WORKDIR /app

COPY --from=builder /builder/extracted/dependencies/ ./
COPY --from=builder /builder/extracted/spring-boot-loader/ ./
COPY --from=builder /builder/extracted/snapshot-dependencies/ ./
COPY --from=builder /builder/extracted/application/ ./

# We are rrunning application on port 8080
EXPOSE 8080

# entry point of the app
ENTRYPOINT [ "java", "org.springframework.boot.loader.JarLauncher" ]
