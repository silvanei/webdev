#!/usr/bin/env bash
function docker_alias() {
    docker run -it --rm --user $(id -u):$(id -g) -v `pwd`:`pwd` -w `pwd` --add-host=host.docker.internal:host-gateway --network global-default ${@:1}
}

function docker_swoole_alias() {
    docker run -it --init --rm --user $(id -u):$(id -g) -v `pwd`:`pwd` -w `pwd` --add-host=host.docker.internal:host-gateway --network host ${@:1}
}


alias php-5.6='docker_alias -e XDEBUG_CONFIG="idekey=PHPSTORM" silvanei/php:5.6-fpm php -dxdebug.remote_enable=1 -dxdebug.remote_host=host.docker.internal'
alias composer-5.6='docker_alias -e XDEBUG_CONFIG="idekey=PHPSTORM" silvanei/php:5.6-fpm composer'

alias php-7.0='docker_alias -e XDEBUG_CONFIG="idekey=PHPSTORM" silvanei/php:7.0-fpm php -dxdebug.remote_enable=1 -dxdebug.remote_host=host.docker.internal'
alias composer-7.0='docker_alias silvanei/php:7.0-fpm composer'

alias php-7.1='docker_alias -e XDEBUG_CONFIG="idekey=PHPSTORM" silvanei/php:7.1-fpm php -dxdebug.remote_enable=1 -dxdebug.remote_host=host.docker.internal'
alias composer-7.1='docker_alias silvanei/php:7.1-fpm composer'

alias php-7.2='docker_alias silvanei/php:7.2-fpm php -dxdebug.client_host=host.docker.internal -dxdebug.start_with_request=yes'
alias composer-7.2='docker_alias silvanei/php:7.2-fpm composer'

alias php-7.3='docker_alias silvanei/php:7.3-fpm php -dxdebug.client_host=host.docker.internal -dxdebug.start_with_request=yes'
alias composer-7.3='docker_alias silvanei/php:7.3-fpm composer'

alias php-7.4='docker_alias silvanei/php:7.4-fpm php -dxdebug.client_host=host.docker.internal -dxdebug.start_with_request=yes'
alias composer-7.4='docker_alias silvanei/php:7.4-fpm composer'

alias php-8.0='docker_alias silvanei/php:8.0-fpm php -dxdebug.client_host=host.docker.internal -dxdebug.start_with_request=yes'
alias composer-8.0='docker_alias silvanei/php:8.0-fpm composer'

alias php-8.0-swoole4.7='docker_swoole_alias silvanei/php:8.0-swoole4.7 php -dyasd.debug_mode=remote -dyasd.remote_host=host.docker.internal -dyasd.remote_port=9003'

# Add, in your ~/.bash_profile file this line, replacing ~/PATH_OF_REPOSITORY with the PATH/directory of this repository.
# source ~/PATH_OF_REPOSITORY/aliases.sh

# Habilita xdebug3
# php-8.0 -dxdebug.mode=debug index.php
# Habilita yasd
# php-8.0-swoole4.7 -e index.php