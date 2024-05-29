# PHP-Apache

Un servidor Apache con PHP en con las especificaciones usadas en los entornos de DEV, TEST y PRODUCCION corriendo en el puerto 8000.

## Construccion de la imagen

Una vez clonado el proyecto y determinada la versión de la imagen a construir se puede utilizar `docker build -t` para la construcción de la misma. 

Esta imagen se publica en [DockerHub](https://hub.docker.com/) con el nombre **industriaspugliesesa/php-apache-7.2.24**. 
Lo que sigue es un ejemplo en donde se construye la versión v2.2.0 de la imagen:


```bash
### Esto es un ejemplo, no olvides modificar la versión a la necesaria
docker build -t industriaspugliesesa/php-apache-7.2.24:2.2.0 .
```
> NOTA: La versión v7.2.24 hace referencia a la versión de PHP que estamos usando para esta imagen y no a la versión de la imagen en sí.

Alternativamente, se puede asignar la versión mayor relativa. Esto hara que aquellos clientes que soliciten el uso de `industriaspugliesesa/php-apache-7.2.24:2` descarguen la versión `v2.2.0`:

```bash
docker tag industriaspugliesesa/php-apache-7.2.24:2.2.0 industriaspugliesesa/php-apache-7.2.24:2
```

## Publicación de la imagen

La publicación de la imagen se realiza mediante DockerHub. Para ello es necesario contar con las credenciales asociadas a  `industriaspugliesesa` y realizar el login en consola:

```bash
docker login -u industriaspugliesesa
```

> Se le solicitará una clave de acceso.

Una vez hecho el login se puede realizar el correspondiente push.

```bash
docker push industriaspugliesesa/php-apache-7.2.24
```

Tras lo cual la nueva versión debería estar disponible.

**IMPORTANTE** No olvidar cerrar sesión una vez que finalices.

```bash
docker logout
```

