FROM php:7.3-fpm-alpine

COPY conf/40-custom.ini /usr/local/etc/php/conf.d/40-custom.ini

WORKDIR /var/www

RUN set -e \
    && apk update \
    && apk add --no-cache icu-dev \
    && apk add --no-cache libzip-dev \
    && apk add --no-cache g++ \
    && apk add --no-cache make \
    && apk add --no-cache autoconf \
#    Dependencias webgrind
    && apk add --no-cache python3 \
    && apk add --no-cache graphviz \
    && if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi

RUN docker-php-ext-install mysqli pdo_mysql opcache intl zip bcmath

RUN pecl install xdebug-2.7.0RC2 redis
RUN docker-php-ext-enable xdebug redis

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN sed -e 's/;pm.status_path = \/status/pm.status_path = \/status/' -i /usr/local/etc/php-fpm.d/www.conf
