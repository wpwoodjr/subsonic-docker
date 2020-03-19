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
    htop \
    nano \
    less \
    locales \
    tzdata \
    openjdk-8-jre-headless

WORKDIR /tmp
COPY subsonic-6.1.6.deb .
RUN apt-get install ./subsonic-6.1.6.deb

ARG LOCALE="en_US.UTF-8"
RUN locale-gen $LOCALE && update-locale LANG=$LOCALE
ARG TZ="America/New_York"
RUN unlink /etc/localtime \
&& ln -s /usr/share/zoneinfo/$TZ /etc/localtime

# stop deletes it too?
# check dirs... playlists etc
# bind /var/playlists to /mnt/01CE739A5B572A40/Users/Public/Music/WPW/Playlists
ARG SUBSONIC_USER="subsonic"
RUN useradd -u 1000 -U $SUBSONIC_USER
ARG SUBSONIC_ARGS=""
RUN echo "\nSUBSONIC_USER=$SUBSONIC_USER" \
  "\nSUBSONIC_ARGS=\"\$SUBSONIC_ARGS $SUBSONIC_ARGS\"" >>/etc/default/subsonic

# java -Xmx150m -Dsubsonic.home=/var/subsonic -Dsubsonic.host=0.0.0.0 -Dsubsonic.port=4040 -Dsubsonic.httpsPort=0 -Dsubsonic.contextPath=/ -Dsubsonic.db= -Dsubsonic.defaultMusicFolder=/var/music -Dsubsonic.defaultPodcastFolder=/var/music/Podcast -Dsubsonic.defaultPlaylistFolder=/var/playlists -Djava.awt.headless=true -verbose:gc -jar subsonic-booter-jar-with-dependencies.jar
# docker run -d --name=name container tail -f /dev/null
CMD tail -f /dev/null

# $ /usr/bin/subsonic --help
# Usage: subsonic.sh [options]
#   --help               This small usage guide.
#   --home=DIR           The directory where Subsonic will create files.
#                        Make sure it is writable. Default: /var/subsonic
#   --host=HOST          The host name or IP address on which to bind Subsonic.
#                        Only relevant if you have multiple network interfaces and want
#                        to make Subsonic available on only one of them. The default value
#                        will bind Subsonic to all available network interfaces. Default: 0.0.0.0
#   --port=PORT          The port on which Subsonic will listen for
#                        incoming HTTP traffic. Default: 4040
#   --https-port=PORT    The port on which Subsonic will listen for
#                        incoming HTTPS traffic. Default: 0 (disabled)
#   --context-path=PATH  The context path, i.e., the last part of the Subsonic
#                        URL. Typically '/' or '/subsonic'. Default '/'
#   --db=JDBC_URL        Use alternate database. MySQL, PostgreSQL and MariaDB are currently supported.
#   --max-memory=MB      The memory limit (max Java heap size) in megabytes.
#                        Default: 100
#   --pidfile=PIDFILE    Write PID to this file. Default not created.
#   --quiet              Don't print anything to standard out. Default false.
#   --default-music-folder=DIR    Configure Subsonic to use this folder for music.  This option 
#                                 only has effect the first time Subsonic is started. Default '/var/music'
#   --default-podcast-folder=DIR  Configure Subsonic to use this folder for Podcasts.  This option 
#                                 only has effect the first time Subsonic is started. Default '/var/music/Podcast'
#   --default-playlist-folder=DIR Configure Subsonic to use this folder for playlist imports.  This option 
#                                 only has effect the first time Subsonic is started. Default '/var/playlists'
