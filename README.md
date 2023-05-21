[hub]: https://hub.docker.com/r/henkallsn/fivem_esx_bundle
[git]: https://github.com/Andruida/fivem

# [henkallsn/fivem_esx_bundle][hub] <img align="right" height="250px" src="https://portforward.com/fivem/fivem-logo.png">

This docker image allows you to run a server for FiveM, a modded GTA multiplayer program.
This image includes [txAdmin](https://github.com/tabarra/txAdmin), an in-browser server management software.
Upon first run, the configuration is generated in the host mount for the `/config` directory, and for the `/txData` directory (that contains the txAdmin configuration).
This bundle is made with a inbuild Mariadb server.
There is also a tag so you can use this without inbuild database. Light version.

[dockerhub]: https://hub.docker.com/r/henkallsn/fivem_esx_bundle
[github]: https://github.com/henkall/fivem
[![](https://images.microbadger.com/badges/image/henkallsn/fivem_esx_bundle.svg)](https://microbadger.com/images/henkallsn/fivem_esx_bundle)
[![Latest Version](https://images.microbadger.com/badges/version/henkallsn/fivem_esx_bundle.svg)][dockerhub]
[![Docker Pulls](https://img.shields.io/docker/pulls/henkallsn/fivem_esx_bundle.svg)][dockerhub]
[![Docker Stars](https://img.shields.io/docker/stars/henkallsn/fivem_esx_bundle.svg)][dockerhub]
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/paypalme/henkallsn)

## Licence Key

A freely obtained licence key is required to use this server, which should be declared as `FIVEM_LICENCE_KEY`. A tutorial on how to obtain a licence key can be found [here](https://forum.fivem.net/t/explained-how-to-make-add-a-server-key/56120)

## Usage

Use the docker-compose script as provided:

```sh
---
version: '2'
services:
# -------------------------------------------------------------------
  fivem:
    image: henkallsn/fivem_esx_bundle
    stdin_open: true
    tty: true
    volumes:
      # Remember to change.
      - "/path/to/resources/folder:/config"
      # Remember to change.
      - "/path/to/txAdmin/config:/txData"
      # Remember to change.
      - "/path/to/mysql/data:/var/lib/mysql"
    ports:
      - "30120:30120"
      - "30120:30120/udp"
      - "40120:40120"
    environment:
      SERVER_PROFILE: "default"
      FIVEM_PORT: 30120
      TXADMIN_PORT: 40120
      HOST_UID: 1000
      HOST_GID: 100
      # Remember to change.
      FIVEM_HOSTNAME: hostname-to-fivem-gameserver
      # Remember to change.
      FIVEM_LICENCE_KEY: license-key-here
      # Remember to change.
      STEAM_WEBAPIKEY: api-key-herer
      # Database stuff ---------------
      DATABASE_SERVICE_NAME: fivem
      MYSQL_DATABASE: FiveMESX
      MYSQL_USER: database username
      MYSQL_PASSWORD: database password
      MYSQL_RANDOM_ROOT_PASSWORD: 1
      # Change to your timezone
      TZ: Europe/Copenhagen
# -------------------------------------------------------------------
  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    ports:
      - 8100-8105:80
    environment:
      - PMA_HOST=fivem
    depends_on:
      - fivem
# -------------------------------------------------------------------
```

_It is important that you use `interactive` and `pseudo-tty` options otherwise the container will crash on startup_
See [issue #3](https://github.com/spritsail/fivem/issues/3)

## Important Tags
| **Tag name** | **Description** |
|---|---|
|latest| This tag is used by default. Use the example above /\\ |
|light| This tag is if you wan't a database seperate for the FiveM. Use the example below \\/ |

## Usage of light tag

Use this docker-compose script for the light version:

```sh
---
version: '2'
services:
# -------------------------------------------------------------------
  fivem01:
    image: henkallsn/fivem_esx_bundle:light
    stdin_open: true
    tty: true
    volumes:
      # Remember to change.
      - /path/to/AppData/FiveMESXlight/txData:/txData
    ports:
      - 30120:30120
      - 30120:30120/udp
      - 40120:40120
    environment:
      SERVER_PROFILE: default
      FIVEM_PORT: 30120
      WEB_PORT: 40120
      HOST_UID: 1000
      HOST_GID: 100
      # Remember to change.
      FIVEM_HOSTNAME: FiveMESX-Server
    depends_on:
      - mariadb
# -------------------------------------------------------------------
  mariadb:
    image: mariadb
    volumes:
      # Remember to change.
      - /path/to/AppData/FiveMESXlight/mysql:/var/lib/mysql
    environment:
      # Remember to change.
      MYSQL_ROOT_PASSWORD: password
# -------------------------------------------------------------------
  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    ports:
      - 8100-8105:80
    environment:
      PMA_HOST: mariadb
    depends_on:
      - mariadb
# -------------------------------------------------------------------
```
OBS: When using the light version and the txadmin ask for database then you can just write mariadb in stead of localhost in the config.


### Environment Varibles

| **Variable name** | **Description** | **Value** |
|---|---|---|
| TXADMIN_PORT | Port used for getting to txAdmin webgui. Will be used in the server.cfg. | 40120 |
| FIVEM_PORT | Port used to connect to the FiveM Server. Will be used in the server.cfg. |  30120 |
| STEAM_WEBAPIKEY | This is you Steam Web api key. Will be used in the server.cfg.  |  |
| FIVEM_HOSTNAME | This will be the FiveM Server name in game. Will be used in the server.cfg.  | FiveMESX Game |
| FIVEM_LICENCE_KEY | This is you FiveM License key wich is needed to start the server. Will be used in the server.cfg.  |  |
| DATABASE_SERVICE_NAME | Has to be the same as the service name. Will be used in the server.cfg. (connection string) | fivem |
| MYSQL_DATABASE | This is what you want your database to be named. Will be used in the server.cfg. (connection string) | FiveMESXDB |
| MYSQL_USER | This is the database user name. Change to what you want. Will be used in the server.cfg. (connection string) | user |
| MYSQL_PASSWORD | This is the database password. Change to what you want. Will be used in the server.cfg. (connection string) | passsword |

- `RCON_PASSWORD` - A password to use for the RCON functionality of the fxserver. If not specified, a random 16 character password is assigned. This is only used upon creation of the default configs
- `HOST_GID` - The files that are generated by the container will be written with this group ID. You must use numeric IDs. If not specified, will use `0` (root).
- `HOST_UID` - The files that are generated by the container will be written with this user ID. You must use numeric IDs. If not specified, will use `0` (root).
- `SERVER_PROFILE` - profile name used by txAdmin. If not specified, will use `dev_server`.

## Credits
<img align="right" height="200px" src="https://raw.githubusercontent.com/tabarra/txAdmin/master/docs/banner.png">

 - This image is based on the [yobasystems/alpine-mariadb](https://hub.docker.com/r/yobasystems/alpine-mariadb) image.
 - Thanks to **tabarra** as the creator and maintainer of the [txAdmin](https://github.com/tabarra/txAdmin) repository!
 - Thanks to [Andruida][git] that I forked this code from
