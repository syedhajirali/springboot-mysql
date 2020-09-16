FROM openjdk:8
COPY target/springboot-mysql.jar /springboot-mysql.jar
EXPOSE 8080/tcp
ENTRYPOINT ["java", "-jar", "/springboot-mysql.jar"]
