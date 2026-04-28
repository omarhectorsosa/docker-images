# Comandos docker. 

## Uso de Docker

### Ambiente docker mediante Dockerfile (confección)

1. Crear en el raiz del proyecto un archivo  `Dockerfile`
1. Escribir la linea `FROM httpd:2.4` para usar solo apache
1. Escribir la linea  `COPY ./proyector /usr/local/apache2/htdocs/` para copiar los archivos de la aplicación al contenedor.
1. Escribir la linea `WORKDIR /usr/local/apache2/htdocs/` para indicar el espacio de trabajo
1. Escribir la linea `EXPOSE 8080` como opcion para exponer el puerto 8080 para que se pueda acceder al servidor web: 

```javascript
FROM httpd:2.4
COPY ./proyector /usr/local/apache2/htdocs/
WORKDIR /usr/local/apache2/htdocs/
```

### General la imagen

Cada vez que se crea una nueva version de imagen desde `image: myapp:tag` (porque se cambio el codigo fuente)

```bash
docker build .
```

#### Corre el docker

```bash
docker run -db --name docker_name -p 8080:8080
```

### Debug y detener el container

```bash
$ docker image ls
$ docker ps
$ docker logs -f CONTAINER
````

### Detener y eliminar docker

```bash
$ docker stop CONTAINER
$ docker rmi -f CONTAINER
```

## Subir al dockerhub la imagen para luego reutilizarla

```bash
$ docker login
$ docker tag «id image» user/image:tagname
$ docker push user/image:tagname
docker rmi $(docker images -a -q)
```

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
$ docker build -t ososa2022/php-apache-simple-8.2.24:1.0.0 .
$ docker tag ososa2022/php-apache-simple-8.2.0:1.0.0 ososa2022/php-apache-simple-8.2.0:1.0.0
$ docker login -u ososa2022 -p ciroylana2022
$ docker push ososa2022/php-apache-simple-8.2.0:1.0.0
$ docker logout
```

## Eliminar docker image

```bash
$ docker image prune -f
```







