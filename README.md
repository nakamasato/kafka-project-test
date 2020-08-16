# kafka-project-test

![dev](https://github.com/nakamasato/kafka-project-test/workflows/dev/badge.svg)

## Version

- Java: 1.7
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

Update pom (#2)

```diff
+          <configuration>
+            <archive>
+              <manifest>
+                <addClasspath>true</addClasspath>
+                <classpathPrefix>lib/</classpathPrefix>
+                <mainClass>practice.App</mainClass>
+              </manifest>
+            </archive>
+          </configuration>
```

## How to run

```
ava -jar target/kafka-project-test-1.0-SNAPSHOT.jar
Hello World!
```

## Github Actions for Java

https://docs.github.com/en/actions/language-and-framework-guides/building-and-testing-java-with-maven

- Cache (First time: 28s -> Second time: 15s)
