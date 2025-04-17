FROM openjdk:17
COPY ./src/main/java/org/example /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac App.java
CMD ["java", "App"]
