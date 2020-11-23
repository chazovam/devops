FROM ubuntu:latest
RUN apt-get update && apt-get -y install openjdk-11-jdk maven git wget
RUN mkdir /usr/local/tomcat
RUN useradd -r -m -U -d /usr/local/tomcat -s /bin/false tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.40/bin/apache-tomcat-9.0.40.tar.gz -O /tmp/tomcat.tar.gz
RUN tar xf /tmp/tomcat.tar.gz -C /tmp && cp -Rv /tmp/apache-tomcat-9.0.40/* /usr/local/tomcat/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/boxfuse
RUN mvn package -f /tmp/boxfuse/pom.xml
RUN cp /tmp/boxfuse/target/hello-1.0.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]