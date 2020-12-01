FROM php:5.6-fpm-alpine3.8

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    TZ="America/Sao_Paulo"

RUN set -e \
    && apk update --no-cache \
    && apk add --no-cache --virtual .phpize-deps \
        $PHPIZE_DEPS \
        libpng-dev \
        icu-dev \
        libzip-dev \
        libxml2-dev \
    && apk add --no-cache wget \
    && apk add --no-cache icu \
    && apk add --no-cache libpng \
    && apk add --no-cache git \
    && apk add --no-cache zip \
    && apk add --no-cache musl-dev \
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
    # blackfire
    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/alpine/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get ('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=${BLACKFIRE_AGENT_SOCKET}\n" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz \
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
