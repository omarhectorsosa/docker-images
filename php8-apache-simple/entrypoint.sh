#!/usr/bin/env bash
set -e

# Instalar dependencias PHP (si hay composer.json)
if [ -f composer.json ]; then
  echo "📦 Instalando dependencias con Composer..."
  composer install -n --no-progress --prefer-dist
fi

# Ejecutar el comando que venga del CMD (Apache por defecto)
exec "$@"
