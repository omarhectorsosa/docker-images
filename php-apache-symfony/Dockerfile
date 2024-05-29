ARG php_version=7.2.24-apache
ARG composer_version=latest-2.2.x
FROM php:${php_version}

ENV TERM=xterm-256color
ENV TZ=America/Argentina/Buenos_Aires

RUN sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf
RUN sed -i 's/443/8000/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf
RUN useradd -m -u 1000 -s /bin/bash usuario 
RUN adduser usuario www-data

RUN apt-get update \
  && apt-get install -y unzip cron acl ssh nodejs npm libzip-dev \
  git wget libicu-dev libmemcached-dev libmcrypt-dev libedit-dev libreadline-dev \
  libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
  libldap2-dev libxml2-dev \
  --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
 
RUN docker-php-ext-install  -j$(nproc) gd mysqli pdo_mysql zip mbstring intl ldap opcache readline soap xml bcmath
RUN pecl install memcached-3.0.1 && docker-php-ext-enable memcached

ARG composer_version
RUN wget https://getcomposer.org/download/${composer_version}/composer.phar \
    && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash

COPY ["apache.conf", "/etc/apache2/sites-enabled/000-default.conf"]
COPY ["server.crt", "/etc/apache2/ssl/server.crt"]
COPY ["server.key", "/etc/apache2/ssl/server.key"]
COPY ["entrypoint.sh", "/entrypoint.sh" ]
COPY ["ssh/*", "/root/.ssh/"]
COPY ["ssh/*", "/home/usuario/.ssh/"]
COPY ["bashrc", "/home/usuario/.bashrc"]


RUN chmod 600 /root/.ssh/*
RUN mkdir /var/www/public
RUN setfacl -R -m u:www-data:rwx -m u:usuario:rwx /var/www
RUN setfacl -dR -m u:www-data:rwx -m u:usuario:rwx /var/www
RUN touch /var/www/my_crontab
RUN chmod 644 /var/www/my_crontab
RUN sed -i "s|;*date.timezone =.*|date.timezone = ${TZ}|i" ${PHP_INI_DIR}/php.ini
WORKDIR /var/www
RUN a2enmod rewrite && a2enmod ssl && a2enmod headers && service apache2 restart

RUN npm install -g n
RUN n 14
RUN hash -r

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD cron && apache2-foreground


