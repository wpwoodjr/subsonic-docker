# subsonic-docker
Easy to run Subsonic in Docker with flexible configuration.

## Getting started

After cloning or downloading this repository, `cd` to it and follow the instructions below.

### `build`
If you don't have Docker, install it per your OS instructions, then run:
```
./build
```
This will build the Subsonic container, based on Subsonic 6.1.6.

### `conf`
The `conf` file is where you customize your installation, if required. `conf` contains the following configurable options:

#### `subsonic_dir`
Directory where you downloaded this repo.  You should not need to change this.

#### `music`
Defaults to `music` in `subsonic_dir`.

music="$subsonic_dir"/music

playlists="$subsonic_dir"/playlists
podcasts="$subsonic_dir"/podcasts
config="$subsonic_dir"/subsonic-config

mem="250"
port=14545
#https_port=0

# Sonos requires container to use host ip address
# if you don't use Sonos, just set hostip to 0.0.0.0
# else if your host ip is fixed, set it here
# else set it to blank and the docker container will figure it out
hostip=""

# see below for description of other args you could add
args=""

locale="en_US.UTF-8"
tz="America/New_York"
user="subsonic"
uid="1000"

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
