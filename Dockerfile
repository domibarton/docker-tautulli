FROM debian:9
MAINTAINER Dominique Barton

#
# Create user and group for Tautulli.
#

RUN groupadd -r -g 666 tautulli \
    && useradd -r -u 666 -g 666 -d /tautulli tautulli

#
# Add Tautulli init script.
#

ADD tautulli.sh /tautulli.sh
RUN chmod 755 /tautulli.sh

#
# Install Tautulli and all required dependencies.
#

RUN export VERSION=v2.1.14 \
    && apt-get -q update \
    && apt-get install -qy curl ca-certificates python-setuptools build-essential python-dev libssl-dev  \
    && easy_install pip \
    && curl -o /tmp/tautulli.tar.gz https://codeload.github.com/Tautulli/Tautulli/tar.gz/${VERSION} \
    && tar xzf /tmp/tautulli.tar.gz \
    && mv Tautulli-* tautulli \
    && chown -R tautulli: tautulli \
    && pip install pyOpenSSL \
    && apt-get -y remove curl build-essential python-dev libssl-dev \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

#
# Define container settings.
#

EXPOSE 8181

#
# Start Tautulli.
#

WORKDIR /tautulli
CMD ["/tautulli.sh"]
