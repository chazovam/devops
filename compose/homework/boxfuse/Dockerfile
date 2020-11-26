FROM ubuntu:latest
RUN apt-get update && apt-get -y install openjdk-11-jdk maven git
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/boxfuse
RUN mvn package -f /tmp/boxfuse/pom.xml
RUN cp /tmp/boxfuse/target/hello-1.0.war /shared/