FROM ubuntu:focal
ARG TAGS
WORKDIR /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y sudo software-properties-common && apt-add-repository -y ppa:ansible/ansible && apt update && apt install -y curl git ansible build-essential
COPY . .

RUN useradd -m -s /bin/bash harsh && \
    echo "harsh:123" | chpasswd

# Add 'harsh' to sudoers
RUN usermod -aG sudo harsh

WORKDIR /home/harsh

COPY . ./ansible
WORKDIR /home/harsh/ansible
USER harsh
