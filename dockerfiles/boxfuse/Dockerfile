FROM tomcat:9.0
RUN apt-get update && apt-get install git maven -y 
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git boxfuse
RUN mvn package -f ./boxfuse/pom.xml  -Dmaven.test.skip=true
RUN cp ./boxfuse/target/hello-1.0.war /usr/local/tomcat/webapps/
EXPOSE 8080