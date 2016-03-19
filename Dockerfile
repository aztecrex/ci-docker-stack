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
           stack \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Do each update one at a time for incremental builds. you can combine
# steps from time to time to reduce layer count.
# A possible refinement of this could be to create a recursive build

# stack resolver for 4.0, dependencies layer 0
COPY template/config-0400-0 /tmp/config
WORKDIR /tmp/config
RUN  stack setup \
  && rm -rf /tmp/config

# stack resolver for 4.0, dependencies layer 1
# includes postgres dev library installation
COPY template/config-0400-1 /tmp/config
WORKDIR /tmp/config
RUN  apt-get update \
  && apt-get install -y \
           libpq-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && stack build \
  && rm -rf /tmp/config

