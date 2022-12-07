# FROM maven

# RUN mkdir /app
# WORKDIR /app

# COPY target/fs-back-0.0.1-SNAPSHOT.jar .

# CMD java -jar fs-back-0.0.1-SNAPSHOT.jar

# FROM maven:3.8-openjdk-18

# WORKDIR /usr/src/app

# COPY . .

# CMD ["mvn","spring-boot:run"]

FROM maven:3.8-openjdk-18 as builder

WORKDIR /usr/src/app

COPY . .

RUN mvn clean package -DskipTests=true

FROM openjdk:18-jdk

EXPOSE 8080

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/target/fs-back-*.jar fs-back.jar

CMD ["java","-jar","fs-back.jar"]
