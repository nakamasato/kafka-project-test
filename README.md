# kafka-project-test

![dev](https://github.com/nakamasato/kafka-project-test/workflows/dev/badge.svg)

## Version

- Java: 1.8
- KafkaStreams: 2.5.0

## Prerequisite

- jenv https://www.jenv.be/

    ```
    brew install jenv
    ```

    ```
    jenv local 1.8
    ```

- maven

    ```
    brew install maven
    ```

    ```
    mvn -version
    Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
    ```

## Create Project

```
Define value for property 'groupId': com.masato
Define value for property 'artifactId': kafka-project-test
Define value for property 'version' 1.0-SNAPSHOT: :
Define value for property 'package' com.masato: : practice
Confirm properties configuration:
groupId: com.masato
artifactId: kafka-project-test
version: 1.0-SNAPSHOT
package: practice
```

Update pom with maven-assembly-plugin [How can I create an executable JAR with dependencies using Maven?](https://stackoverflow.com/questions/574594/how-can-i-create-an-executable-jar-with-dependencies-using-maven)

```
        <plugin>
          <artifactId>maven-assembly-plugin</artifactId>
          <configuration>
            <archive>
              <manifest>
                <mainClass>practice.App</mainClass>
              </manifest>
            </archive>
            <descriptorRefs>
              <descriptorRef>jar-with-dependencies</descriptorRef>
            </descriptorRefs>
          </configuration>
        </plugin>
```

## How to run in local

1. Dependent environment variables `.env`

    ```.env
    KAFKA_INPUT_TOPIC=streams-plaintext-input # input topic
    KAFKA_OUTPUT_TOPIC=streams-pipe-output # output topic
    KAFKA_APPLICATION_ID=streams-pipe # application id for kafka streams
    KAFKA_BOOTSTRAP_SERVERS=localhost:9092 # bootstrap servers
    ```

1. Prepare Kafka

    ```
    docker run --rm -it \
            -p 2128:2128 -p 3030:3030 -p 8081:8081 \
            -p 8082:8082 -p 8083:8083 -p 9092:9092 \
            -e ADV_HOST=127.0.0.1 \
            landoop/fast-data-dev
    ```

1. Produce input topic `streams-plaintext-input`

    ```
    docker exec -it $(docker ps | grep landoop | awk '{print $1}') bash
    root@fast-data-dev / $ kafka-console-producer --broker-list 127.0.0.1:9092 --topic streams-plaintext-input
    > aaa
    > aaa
    ```

1. Run application

    - Build docker

        - With compiled jar (Fast)

            ```
            mvn clean compile assembly:single
            docker build -t kafka-project-test . -f .github/Dockerfile
            ```

        - With Docker (Same way as prod)

            ```
            docker build -t kafka-project-test .
            ```

    - Run

        ```
        docker run --env-file=.env --network host --rm kafka-project-test
        ```

1. Check output topic `streams-pipe-output`

    ```
    kafka-console-consumer --bootstrap-server 127.0.0.1:9092 --topic streams-pipe-output --from-beginning
    ```

## Github Actions for Java

https://docs.github.com/en/actions/language-and-framework-guides/building-and-testing-java-with-maven

- Cache (First time: 28s -> Second time: 17s)
