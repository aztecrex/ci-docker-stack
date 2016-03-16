FROM ubuntu:15.10

RUN  apt-get update \
  && rm -rf /var/lib/apt/lists/* \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442 \
  && echo 'deb http://download.fpcomplete.com/ubuntu wily main' \
           | tee /etc/apt/sources.list.d/fpco.list \
  && apt-get update \
  && apt-get install -y \
           git \
           curl \
           unzip \
           libpq-dev \
           stack \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

