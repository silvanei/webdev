FROM php:7.2-fpm-alpine3.12

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    TZ="America/Sao_Paulo"

RUN set -e \
    && apk update \
    && apk add --no-cache --virtual .phpize-deps \
        $PHPIZE_DEPS \
        libpng-dev=1.6.37-r1 \
        icu-dev=67.1-r0 \
        libzip-dev=1.6.1-r1 \
        libxml2-dev=2.9.10-r5 \
    && apk add --no-cache tzdata=2020c-r1 \
    && apk add --no-cache icu=67.1-r0 \
    && apk add --no-cache libpng=1.6.37-r1 \
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
        xdebug-2.9.8 \
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