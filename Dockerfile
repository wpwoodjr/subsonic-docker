# you should not need to modify this Dockerfile

FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# upgrade existing and install base set of packages
RUN apt-get update \
&& apt-get upgrade \
&& apt-get install --no-install-recommends -qq \
    curl \
    nano \
    less \
    locales \
    tzdata \
    iproute2 \
    openjdk-8-jre-headless \
    ffmpeg \
    lame

# install Subsonic
WORKDIR /var/subsonic-docker
COPY ./subsonic-*.deb .
RUN apt-get install ./subsonic-*.deb \
 && rm ./subsonic-*.deb

 # save configuration files to copy back over to /var/subsonic volume mount during first time initialization
RUN ln -sf /usr/bin/ffmpeg /var/subsonic/transcode/ffmpeg \
 && ln -sf /usr/bin/lame /var/subsonic/transcode/lame \
 && cp -a /var/subsonic .

COPY ./run .
RUN chmod +x ./run
