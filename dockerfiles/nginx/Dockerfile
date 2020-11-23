FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install nginx -y
EXPOSE 80
RUN rm -rf /war/www/html/*
ADD index.html /var/www/html/
CMD ["nginx", "-g", "daemon off;"]
