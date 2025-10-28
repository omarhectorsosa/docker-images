# Docker Image, docker tag y docker Hub

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