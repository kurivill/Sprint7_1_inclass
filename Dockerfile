FROM openjdk:17
COPY ./src/main/java/org/example /usr/src/myapp/org/example
WORKDIR /usr/src/myapp
RUN javac -d . org/example/App.java
CMD ["java", "org.example.App"]
