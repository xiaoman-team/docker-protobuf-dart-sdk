FROM ubuntu:18.04

MAINTAINER xiaoman

RUN apt-get update -qq --no-install-recommends && apt-get upgrade -qq --no-install-recommends && apt-get autoclean

RUN apt-get install -qq apt-transport-https wget unzip gnupg2 git && \
    wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && \
    apt-get install dart

ENV PATH="$PATH:/usr/lib/dart/bin" 

RUN mkdir -p /opt/protoc && \
    cd /opt/protoc && \
    wget https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip -O protoc.zip && \
    unzip protoc.zip && \
    rm protoc.zip

ENV PATH="$PATH:/opt/protoc/bin"

RUN pub global activate protoc_plugin

ENV PATH="$PATH":"$HOME/.pub-cache/bin"
