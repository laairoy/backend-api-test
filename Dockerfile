FROM eclipse-temurin:17-jdk-jammy as builder

WORKDIR /app

COPY --chmod=0755 ./mvnw mvnw 
COPY pom.xml /app/pom.xml
COPY src /app/src
COPY .mvn .mvn

RUN ./mvnw clean package -DskipTests
RUN  mv target/*.jar target/app.jar

FROM eclipse-temurin:17-jre-jammy as exec

WORKDIR /app

COPY --from=builder /app/target/app.jar  /app/app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]