# First build stage
FROM maven:3.6.3-jdk-8-slim AS builder

# Creating directorium builder
WORKDIR /builder

# Copy all maven files 
COPY pom.xml .
# Cache dependecies to make pipelin run faster later
RUN mvn dependency:go-offline

# Create jars
COPY src ./src
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
ENV PORT=8080
EXPOSE ${PORT}

# entry point of the app
ENTRYPOINT [ "java", "org.springframework.boot.loader.JarLauncher" ]
