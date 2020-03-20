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
The `conf` file is where you customize your installation as required. `conf` contains the following configurable option variables:

#### `subsonic_dir`
Directory where you downloaded this repo.  You should not need to change this unless the auto-detect fails for some reason.

#### `music`
Directory containing your music files.

Defaults to `music` in `subsonic_dir`.  You can change `music` to point directly to your music directory, or alternatively you can create a symbolic link in `subsonic_dir` from `music` to your music directory:
```
ln -s /your-music/ music

```
If you don't change `music`, a new directory called `music` will be created in `subsonic_dir`.

#### `playlists`
Directory containing your playlist files.

Defaults to `playlists` in `subsonic_dir`.  You can change `playlists` to point directly to your playlists directory, or alternatively you can create a symbolic link in `subsonic_dir` from `playlists` to your playlists directory:
```
ln -s /your-playlists/ playlists

```
If you don't change `playlists`, a new directory called `playlists` will be created in `subsonic_dir`.

#### `podcasts`
Directory containing your podcasts.

Defaults to `podcasts` in `subsonic_dir`.  You can change `podcasts` to point directly to your podcasts directory, or alternatively you can create a symbolic link in `subsonic_dir` from `podcasts` to your podcasts directory:
```
ln -s /your-podcasts/ podcasts

```
If you don't change `podcasts`, a new directory called `podcasts` will be created in `subsonic_dir`.

#### `data`
This is where Subsonic maintains its database and configuration.

Defaults to `data` in `subsonic_dir`.  You can change `data` to point directly to your Subsonic data directory, or alternatively you can create a symbolic link in `subsonic_dir` from `data` to your Subsonic data directory:
```
ln -s /your-subsonic-data/ data

```
If you don't change `data`, a new directory called `data` will be created in `subsonic_dir`.

#### `mem`
The memory limit (max Java heap size) in megabytes.  Defaults to `250`. Unless your music collection is huge, this should be fine.

#### `port`
The port on which Subsonic will listen for incoming HTTP traffic.  Subsonic's default port is `4040`, but you may prefer to set it to something else since it is a well known port.
`port` should be greater than `1024`.

#### `https_port`
Not supported at this time.

#### `hostip`
Sonos requires that the container use the host's ip address, not a container ip address.
By default `hostip` is blank, which tells the container to discover the ip address of the host.  If it fails for some reason, then if your host ip is fixed, set `hostip` to that ip address. Otherwise, just set hostip to `0.0.0.0`.

#### `locale`
Default locale is `en_US.UTF-8`.

See https://www.tecmint.com/set-system-locales-in-linux/ for more info.

#### `tz`
Default time zone is `America/New_York`.  Set this to your time zone so that Subsonic's scheduled time for "Scan media folders" reflects your time zone.

See https://linuxize.com/post/how-to-set-or-change-timezone-in-linux/ for more info.

#### `user` and `uid`
By default Subsonic runs in the container under the user `subsonic` with uid `1000`.
Set `uid` to your uid to grant user `subsonic` write permissions in the music directories, otherwise changing album art and tags will fail.

If problems persist, you can try changing `user` to `root`, although from a security perspective it is better to run as a non-root user.

#### `args`
Defaults to blank.
You probably won't need to add any args, as most are configured already above.
For reference here is the Subsonic options help:
```
Usage: subsonic.sh [options]
  --help               This small usage guide.
  --home=DIR           The directory where Subsonic will create files.
                       Make sure it is writable. Default: /var/subsonic
  --host=HOST          The host name or IP address on which to bind Subsonic.
                       Only relevant if you have multiple network interfaces and want
                       to make Subsonic available on only one of them. The default value
                       will bind Subsonic to all available network interfaces. Default: 0.0.0.0
  --port=PORT          The port on which Subsonic will listen for
                       incoming HTTP traffic. Default: 4040
  --https-port=PORT    The port on which Subsonic will listen for
                       incoming HTTPS traffic. Default: 0 (disabled)
  --context-path=PATH  The context path, i.e., the last part of the Subsonic
                       URL. Typically '/' or '/subsonic'. Default '/'
  --db=JDBC_URL        Use alternate database. MySQL, PostgreSQL and MariaDB are currently supported.
  --max-memory=MB      The memory limit (max Java heap size) in megabytes.
                       Default: 100
  --pidfile=PIDFILE    Write PID to this file. Default not created.
  --quiet              Don't print anything to standard out. Default false.
  --default-music-folder=DIR    Configure Subsonic to use this folder for music.  This option 
                                only has effect the first time Subsonic is started. Default '/var/music'
  --default-podcast-folder=DIR  Configure Subsonic to use this folder for Podcasts.  This option 
                                only has effect the first time Subsonic is started. Default '/var/music/Podcast'
  --default-playlist-folder=DIR Configure Subsonic to use this folder for playlist imports.  This option 
                                only has effect the first time Subsonic is started. Default '/var/playlists'
```
