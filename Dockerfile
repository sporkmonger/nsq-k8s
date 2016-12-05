FROM debian:8.6

EXPOSE 4150 4151 4160 4161 4170 4171

VOLUME /data
VOLUME /etc/ssl/certs

ENV NSQ_VERSION=0.3.8
ENV GO_VERSION=1.6.2

RUN mkdir -p /usr/local/bin/ && apt-get update && apt-get install -y wget && \
  wget https://github.com/nsqio/nsq/releases/download/v$NSQ_VERSION/nsq-$NSQ_VERSION.linux-amd64.go$GO_VERSION.tar.gz -P /tmp/ && \
  tar xzvf /tmp/nsq-$NSQ_VERSION.linux-amd64.go$GO_VERSION.tar.gz -C /tmp/ && \
  mv /tmp/nsq-$NSQ_VERSION.linux-amd64.go$GO_VERSION/bin/*nsq* /usr/local/bin/ && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN ln -s /usr/local/bin/*nsq* / \
    && ln -s /usr/local/bin/*nsq* /bin/
