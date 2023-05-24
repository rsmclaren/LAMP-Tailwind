# LAMP with Tailwind boilerplate

### local setup

run the below command to build the image, create and start the containers

```
docker-compose up --build
```

if image is already built use the following to start the containers in detached mode

```
docker-compose up -d
```

## Docker services

### web-server

A php image built using the Docker official image from [DockerHub](https://hub.docker.com/_/php). Defined in the php.Dockerfile. Can be accessed from http://localhost:8080

### mysql-server

a mysql image built from DockerHub.

- username = root

### phpmyadmin

a phpmyadmin image built from DockerHub. Can be accessed from http://localhost:5000

### .env

your mysql root password must be set using a .env file.

```
MYSQL_ROOT_PASSWORD = "your root password"
```

## bundle and build css
install required node modules using `npm install` from the `src` directory

to watch and build css run `npm run watch`

## ini
The `upload.ini` can be used to control php upload settings

## apache
The `000-default.conf` file can be used to modify the default vhost settings for the apache server.