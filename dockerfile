FROM nginx:latest

RUN apt-get update && apt-get upgrade -y

RUN apt-get install python3 -y
RUN mkdir HostingSetup
WORKDIR /HostingSetup

ENV ProxyURL="0.0.0.0"
ENV WebProxyPort="8080"

EXPOSE 2222
EXPOSE 80

CMD ["/setup.sh"]