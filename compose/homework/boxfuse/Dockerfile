FROM openjdk:8-alpine
RUN apk upgrade && \
    apk add wget maven git 
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/boxfuse
RUN mvn package -f /tmp/boxfuse/pom.xml
WORKDIR /shared
RUN cp /tmp/boxfuse/target/hello-1.0.war /shared/