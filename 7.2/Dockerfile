FROM php:7.2-fpm-alpine

COPY conf/40-custom.ini /usr/local/etc/php/conf.d/40-custom.ini

WORKDIR /var/www

RUN set -e \
    && apk update \
    && apk add --no-cache icu-dev \
    && apk add --no-cache libzip-dev \
    && apk add --no-cache g++ \
    && apk add --no-cache make \
    && apk add --no-cache autoconf

RUN docker-php-ext-install mysqli pdo_mysql opcache intl zip bcmath

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug


ENV COMPOSER_ALLOW_SUPERUSER=1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN pecl install timecop-beta
RUN docker-php-ext-enable timecop
