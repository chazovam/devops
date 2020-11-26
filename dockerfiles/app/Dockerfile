FROM ubuntu:14.04
COPY requirements.txt /tmp/
WORKDIR /tmp
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-all python-pip
RUN pip install -qr requirements.txt
COPY app.py /opt/webapp/app.py 
EXPOSE 5000
ENTRYPOINT [ "python", "/opt/webapp/app.py" ]