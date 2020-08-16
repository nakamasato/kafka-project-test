FROM maven:3.5.3-jdk-8-alpine as target
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ /build/src/
RUN mvn compile assembly:single

FROM openjdk:8-jre-alpine
COPY --from=target /build/target/*jar-with-dependencies.jar /app/kafka-project-test.jar
CMD ["java", "-jar", "./app/kafka-project-test.jar"]
