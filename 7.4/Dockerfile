FROM php:7.4.1-fpm-alpine3.10

# https://snyk.io/blog/10-docker-image-security-best-practices/
# Teste da imagem https://medium.com/@aelsabbahy/tutorial-how-to-test-your-docker-image-in-half-a-second-bbd13e06a4a9
LABEL maintanier="ads.silvanei@gmail.com"
LABEL alpine-package-version="https://pkgs.alpinelinux.org/packages?name=nginx&branch=v3.10&repo=main&arch=x86"

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    TZ="America/Sao_Paulo"

COPY conf/40-custom.ini /usr/local/etc/php/conf.d/40-custom.ini

RUN set -e \
    && apk update --no-cache \
    && apk add --no-cache tzdata=2019c-r0 \
    && apk add --no-cache icu-dev=64.2-r0 \
    && apk add --no-cache libzip-dev=1.5.2-r0 \
    && apk add --no-cache g++=8.3.0-r0 \
    && apk add --no-cache make=4.2.1-r2 \
    && apk add --no-cache autoconf=2.69-r2 \
    # Dependencias webgrind
    && apk add --no-cache python3=3.7.5-r1 \
    && apk add --no-cache graphviz=2.40.1-r1 \
    && if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi \
    # Dependencias php
    && docker-php-ext-install \
        mysqli \
        pdo_mysql \
        opcache \
        intl \
        zip \
        bcmath \
    && pecl install \
        xdebug \
        redis \
    && docker-php-ext-enable \
        xdebug \
        redis \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require hirak/prestissimo \
    && composer global require psy/psysh:@stable \
    #   Clear install
    && pecl clear-cache \
    && composer clear-cache \
    && docker-php-source delete \
    && rm -rf /var/cache/* \
    && rm -Rf /tmp/*

WORKDIR /var/www
