FROM openjdk:8-alpine as app
RUN apk upgrade && apk add wget maven git 
RUN git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git /tmp/app
RUN mvn package -f /tmp/app/pom.xml

FROM openjdk:8-jre-alpine
RUN apk upgrade && apk add wget 
WORKDIR /usr/local/tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz -O /tmp/tomcat.tar.gz
RUN tar xf /tmp/tomcat.tar.gz -C /tmp && cp -Rv /tmp/apache-tomcat-8.5.61/* /usr/local/tomcat/
WORKDIR /usr/local/tomcat/ROOT
COPY Config.properties Config.properties
WORKDIR /usr/local/tomcat 
COPY --from=app /tmp/app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war webapps/app.war 
COPY --from=app /tmp/app/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT/WEB-INF/lib/* lib/ 
EXPOSE 8080
CMD ["bin/catalina.sh", "run"]