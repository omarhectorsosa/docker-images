# Comandos docker (crear y ejecutar en local) 

## Crear el Dockfile 

1. Usar un Apache solo: `FROM httpd:2.4` 
1. Copia los archivos de la aplicación al contenedor : `COPY ./proyector /usr/local/apache2/htdocs/`
1. indica el espacio de trabajo: `WORKDIR /usr/local/apache2/htdocs/`
1. Como opcional puedes exponer el puerto 8080 para que se pueda acceder al servidor web: `EXPOSE 8080`

##  Crear el archivo dockfile

```
FROM httpd:2.4
COPY ./proyector /usr/local/apache2/htdocs/
WORKDIR /usr/local/apache2/htdocs/
```

## General la imagen

Cada vez que se crea una nueva version de imagen desde image: myapp:tag (porque se cambio el codigo fuente)

```
docker build .
```

#### Corre el docker

`docker run -db --name docker_name -p 8080:8080` 

## Debug docker

`docker image ls`

`docker ps`

`docker logs -f CONTAINER`

### Detener y eliminar docker

`docker stop CONTAINER`

`docker rmi -f CONTAINER`



## Subir al docker hub la imagen

`docker login`

`docker tag «id image» user/image:tagname`

`docker push user/image:tagname`

`docker rmi $(docker images -a -q)`

### Ver mas en [Docker CLI](https://docs.docker.com/engine/reference/run/)


# Docker Image, docker tag y docker Hub (subir a dockerhub)

## Subir imagen al docker hub

Se puedo subir una imgen docker a su cuenta de docker hub (hub.docker.com) 

Primero reviso mi imagen

```bash
$ docker images
REPOSITORY                               TAG       IMAGE ID       CREATED 
myapp                                    v1        0b4e9d242b84   2 hours 
```

Me logueo al docker hub con el CLI y genero el tag correspondiente, por ultimo los llevo por el push.

```bash
$ docker login -u "YOUR_USER_NAME" -p "YOUR_PASSWORD"
$ docker tag myapp:v1  YOUR_USER_NAME/myapp:v1
$ docker push YOUR_USER_NAME/myapp:v1
The push refers to repository [docker.io/ososa2022/myapp]
f42c3eb98a0e: Pushed 
f422e32c38af: Pushed 
....
```

Ejemplo concreto  creando una imagen y la subo en el docker hub (user:ososa2022 pass:ciroylana2022)

```bash
$ docker build -t ososa2022/php-apache-7.2.24:1.0.0 .
$ docker tag ososa2022/php-apache-7.2.24:1.0.0 ososa2022/mariadb-10.2.7:1.0.0
$ docker login -u ososa2022
$ docker push ososa2022/php-apache-7.2.24:1.0.0 
$ docker logout
```

## Eliminar docker image

```bash
$ docker image prune -f
```