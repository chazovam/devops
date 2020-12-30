FROM docker:dind
RUN apk update && apk add git wget unzip ansible

RUN apk add python3 py3-pip && pip3 install --upgrade pip \
    && pip3 install --upgrade pip \
    && pip3 install awscli \
    && rm -rf /var/cache/apk/*
WORKDIR /tmp
RUN wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
RUN unzip terraform*.zip && mv terraform /usr/local/bin

WORKDIR /tmp/t1