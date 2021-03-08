FROM ubuntu:latest
RUN apt update -y
RUN apt install mysql-client netcat curl tzdata -y
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
ADD connectionChecker.sh /src/
ADD memCheck.sh /src/
ADD cpuCheck.sh /src/
ADD dockerCheck.sh /src/
ADD start.sh /src
#ADD start.sh /docker-entrypoint-initdb.d
CMD ["/src/start.sh"]

