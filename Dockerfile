FROM ubuntu:20.04
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN apt-get update && apt-get install -y curl jq git

ADD https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz                        /tmp/docker.tgz
ADD https://github.com/lalyos/dockerhook/releases/download/v0.1.2/dockerhook_0.1.2_linux_x86_64.tgz  /tmp/dockerhook.tgz
ADD https://github.com/dokku/plugn/releases/download/v0.7.0/plugn_0.7.0_linux_amd64.tgz              /tmp/plugn.tgz

RUN    cd /tmp && tar -zxf /tmp/docker.tgz     && rm /tmp/docker.tgz && mv /tmp/docker/docker /bin \
    && cd /bin && tar -zxf /tmp/dockerhook.tgz && rm /tmp/dockerhook.tgz \
    && cd /bin && tar -zxf /tmp/plugn.tgz      && rm /tmp/plugn.tgz \
    && mv /bin/plugn-amd64 /bin/plugn \
    && chmod +x /bin/docker* /bin/plugn \
    && chown root:root /bin/docker* /bin/plugn

ADD ./plugins /plugins
ENV PLUGIN_PATH /plugins

ADD ./start /start
CMD ["/start"]
