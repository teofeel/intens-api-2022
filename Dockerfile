FROM maven:3.6.3-jdk-8-slim AS builder

WORKDIR /builder

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests 

RUN java -Djarmode=layertools -jar target/*.jar extract --destination extracted


FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

COPY --from=builder /builder/extracted/dependencies/ ./
COPY --from=builder /builder/extracted/spring-boot-loader/ ./
COPY --from=builder /builder/extracted/snapshot-dependencies/ ./
COPY --from=builder /builder/extracted/application/ ./

ENV PORT=8080
EXPOSE ${PORT}

ENTRYPOINT [ "java", "org.springframework.boot.loader.JarLauncher" ]
