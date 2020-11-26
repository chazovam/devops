FROM openjdk:8-jre-alpine
WORKDIR /usr/local/tomcat
RUN apk upgrade --update && \
    apk add --update wget
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.40/bin/apache-tomcat-9.0.40.tar.gz -O /tmp/tomcat.tar.gz
RUN tar xf /tmp/tomcat.tar.gz -C /tmp && cp -Rv /tmp/apache-tomcat-9.0.40/* /usr/local/tomcat/
EXPOSE 8080
CMD ["bin/catalina.sh", "run"]