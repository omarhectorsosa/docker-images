#!/usr/bin/env bash

echo -e "\n\033[00;44m*** Instalación de paquetes via COMPOSER ***\033[0m\n"
composer install -n 
result=$?

if [ $result -ne 0 ]
then
  echo -e "\n\033[01;41m*** Falló la instalación de paquetes vía COMPOSER. ***\033[0m\n"
  exit 1
else
   echo -e "\n\033[01;42m[ COMPOSER OK ]\033[0m\n"
fi

echo -e "\n\033[00;44m*** Instalación de paquetes via NPM ***\033[0m\n"
npm ci
result=$?

if [ $result -ne 0 ]
then
  echo -e "\n\033[01;31mAtención: \033[01;33m*** Falló la instalación de paquetes vía NPM. ***\033[0m\n" 
else
  echo -e "\n\033[01;42m[ NPM INSTALL OK ]\033[0m\n"
fi

echo -e "\n\033[00;44m*** NPM RUN BUILD ***\033[0m\n"
npm run build
result=$?

if [ $result -ne 0 ]
then
  echo -e "\n\033[01;31mAtención: \033[01;33m*** Falló build vía NPM. ***\033[0m\n"
else
  echo -e "\n\033[01;42m[ NPM BUILD OK ]\033[0m\n"
fi


echo -e "\n\033[00;44m*** Validando MIGRATIONS. ***\033[0m\n"
php bin/console doctrine:migration:status  --quiet
result=$?

while [ $result -ne 0 ]; do
    echo -e "\n\033[00;41m*** Fallo de conexión o configuración.Reitentando en 5 segundos.. ***\033[0m\n" 
    php bin/console doctrine:migration:status --quiet
    result=$?
    sleep 5 
done

php bin/console doctrine:migration:migrate --no-interaction

echo -e "\n\033[00;44m*** Configurando permisos. ***\033[0m\n"

chown --recursive usuario.www-data vendor/ public/build/ node_modules/ var/

echo -e "\n\033[00;44m*** INICIANDO SERVIDOR  =) ***\033[0m\n"

exec "$@"
