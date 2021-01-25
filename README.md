# Houston

Docker dev environments.

## Install

Houston sets up a local Docker-based dev environment per project. Requires Docker.

```bash
composer require stuntrocket/houston

# Publish files and folders
composer run publish

# Run once to initialise
bash houston init

./houston start
```

View `http://localhost` in your browser.

## Multiple Environments

Binds to port 80 and 3306 on your machine.

If you run more than one instance of Houston, you'll get an error when starting it because each port can only be used once. 
To get around this, use a different port per project by setting the `APP_PORT` and `DB_PORT` environment variables in one of two ways:

Within the `.env` file:

```
APP_PORT=8080
DB_PORT=33060
```

Or when starting Houston:

```bash
APP_PORT=8080 DB_PORT=33060 ./houston start
```

Then you can view your project at `http://localhost:8080` and access your database locally from port `33060`;

## Mysql

Binds MySQL to port `3306`, so we can access the database using GUI.

The password for user `root` is set by environment variable `DB_PASSWORD` from within the `.env` file.

> The port setting must match the `DB_PORT` environment variable, which defaults to `3306`.

## Common Commands

Any command not defined in the `houston` script will default to being passed to the `docker-compose` command. 
If no command is used, it will run `docker-compose ps` and list running containers.

### Houston Version and Help

```bash
# shows houston current version
$ houston --version # or [ -v | version ]

# shows houston help
$ houston --help # or [ -H | help ]
```

### Starting and Stopping Containers

```bash
# Start the environment
./houston start

## This is equivalent to
./houston up -d

# Stop the environment
./houston stop

## This is equivalent to
./houston down
```

### Development

```bash
# Use composer
./houston composer <cmd>
./houston comp <cmd> # "comp" is a shortcut to "composer"

# Use artisan
./houston artisan <cmd>
./houston art <cmd> # "art" is a shortcut to "artisan"

# Run tinker REPL
./houston tinker # "tinker" is a shortcut for "artisan tinker"

# Run phpunit tests
./houston test

## Example: You can pass anything you would to phpunit to this as well
./houston test --filter=some.phpunit.filter
./houston test tests/Unit/SpecificTest.php


# Run npm
./houston npm <cmd>

## Example: install deps
./houston npm install

# Run yarn

./houston yarn <cmd>

## Example: install deps
./houston yarn install

# Run gulp
./houston gulp <cmd>
```

### Docker Commands

Anything command recognized as built-in, will be used as an argument for `docker-compose` command.

```bash
# List running containers
./houston
./houston ps

# Viewcontainer service log
./houston logs # all container logs
./houston logs app # nginx | php logs
./houston logs mysql # mysql logs
./houston logs redis # redis logs

## Tail logs
./houston logs -f # all logs
./houston logs -f app # nginx | php logs

## Tail Laravel Logs
./houston exec app tail -f /var/www/html/storage/logs/laravel.log

# Start a bash shell inside of a container
# This is just like SSH'ing into a server
# Note that changes to a container made this way will **NOT**
#   survive through stopping and starting the houston environment
#   To install software or change server configuration, you'll need to
#     edit the Dockerfile and run: ./houston build
./houston exec app bash

# Example: mysqldump database "homestead" to local file system
#          We must add the password in the command line this way
#          This creates files "homestead.sql" on your local file system, not
#          inside of the container
./houston exec mysql mysqldump -u root -psecret homestead > homestead.sql
```


## Containers

* PHP 7.4
* MySQL 5.7
* Redis ([latest](https://hub.docker.com/_/redis/))
* NodeJS ([latest](https://hub.docker.com/_/node/)) with Yarn & NPM

## Docker Supported Systems

Houston requires Docker and works on Windows, Mac and Linux.

> Windows requires running Hyper-V. Using Git Bash (MINGW64) and WSL are supported. Native
  Windows is still under development.

| Mac                                                                      |                                              Linux                                              |                                     Windows                                      |
| ------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------: |
| Install Docker on [Mac](https://docs.docker.com/docker-for-mac/install/) | Install Docker on [Debian](https://docs.docker.com/engine/installation/linux/docker-ce/debian/) | Install Docker on [Windows](https://docs.docker.com/docker-for-windows/install/) |
|                                                                          | Install Docker on [Ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) |                                                                                  |
|                                                                          | Install Docker on [CentOS](https://docs.docker.com/engine/installation/linux/docker-ce/centos/) |                                                                                  |
