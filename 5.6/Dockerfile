FROM php:5.6-fpm-alpine

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY conf/40-custom.ini /usr/local/etc/php/conf.d/40-custom.ini

RUN set -e \
    && apk update --no-cache \
    && apk add --no-cache wget \
    && apk add --no-cache zlib-dev \
    && apk add --no-cache icu-dev \
    && apk add --no-cache g++ \
    && apk add --no-cache make \
    && apk add --no-cache autoconf \
    && apk add --no-cache libxml2-dev \
    && apk add --no-cache libpng-dev \
    && apk add --no-cache git \
    && apk add --no-cache zip \
    && apk add --no-cache musl-dev \
    && rm -rf /var/cache/* \
    && rm -Rf /tmp/*

RUN docker-php-ext-configure intl \
    && docker-php-ext-install \
        mysql \
        pdo_mysql \
        intl \
        soap \
        mysqli \
        bcmath \
        gd \
    && pecl install \
        xdebug-2.5.0 \
        timezonedb \
    && docker-php-ext-enable \
        xdebug \
        timezonedb \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    #   Clear install
    && pecl clear-cache \
    && composer clear-cache \
    && docker-php-source delete \
    && rm -rf /var/cache/* \
    && rm -Rf /tmp/*
