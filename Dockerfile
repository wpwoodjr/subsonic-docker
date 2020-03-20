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
    openjdk-8-jre-headless

# install Subsonic
WORKDIR /var/subsonic-docker
COPY ./subsonic-*.deb .
RUN apt-get install ./subsonic-*.deb
RUN rm ./subsonic-*.deb
# save configuration files for first time intialization
RUN cp -r /var/subsonic .

COPY ./run .
RUN chmod +x ./run
