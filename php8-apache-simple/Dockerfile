ARG php_version=8.1.0-apache
ARG composer_version=latest-2.2.x
FROM php:${php_version}

ENV TERM=xterm-256color
ENV TZ=America/Argentina/Buenos_Aires

# Cambiar el puerto por defecto de Apache a 8000
RUN sed -i 's/80/8000/g' /etc/apache2/ports.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update \
  && apt-get install -y unzip cron acl ssh nodejs npm libzip-dev \
  git wget libicu-dev libmemcached-dev libmcrypt-dev libedit-dev libreadline-dev \
  libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
  libldap2-dev libxml2-dev \
  --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd zip pdo pdo_mysql

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY apache.conf /etc/apache2/sites-enabled/000-default.conf 

ARG composer_version
RUN wget https://getcomposer.org/download/${composer_version}/composer.phar \
    && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash

RUN a2enmod rewrite

COPY . /var/www/
WORKDIR /var/www/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
