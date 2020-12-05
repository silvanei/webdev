FROM php:7.4.13-fpm-alpine3.12

# https://snyk.io/blog/10-docker-image-security-best-practices/
# Teste da imagem https://medium.com/@aelsabbahy/tutorial-how-to-test-your-docker-image-in-half-a-second-bbd13e06a4a9
LABEL name="PHP" \
      Version="7.4" \
      maintanier="ads.silvanei@gmail.com" \
      alpine-package-version="https://pkgs.alpinelinux.org/packages?name=nginx&branch=v3.12&repo=main&arch=x86"

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    TZ="America/Sao_Paulo"

RUN set -e \
    && apk update --no-cache \
    && apk add --no-cache --virtual .phpize-deps \
        $PHPIZE_DEPS \
        libpng-dev=1.6.37-r1 \
        icu-dev=67.1-r0 \
        libzip-dev=1.6.1-r1 \
        libxml2-dev=2.9.10-r5 \
    && apk add --no-cache tzdata=2020c-r1 \
    && apk add --no-cache icu=67.1-r0 \
    && apk add --no-cache libpng=1.6.37-r1 \
    && apk add --no-cache libzip=1.6.1-r1 \
    && docker-php-ext-install \
        mysqli \
        pdo_mysql \
        opcache \
        intl \
        zip \
        bcmath \
        soap \
        gd \
    && pecl install \
        xdebug \
        redis \
        ds \
        timecop-beta \
    && docker-php-ext-enable \
        xdebug \
        redis \
        ds \
        timecop \
    # blackfire
    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/alpine/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get ('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=${BLACKFIRE_AGENT_SOCKET}\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz \
    # composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    #   Clear install
    && pecl clear-cache \
    && composer clear-cache \
    && apk del --no-network .phpize-deps \
    && docker-php-source delete \
    && rm -rf /var/cache/* \
    && rm -Rf /tmp/*

WORKDIR /var/www
