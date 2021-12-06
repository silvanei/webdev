## Ambiente de desenvolvimento com PHP

Clone este projeto dentro de /var/www

### Criar uma rede para os conatiners
```
docker network create global-default
```

### Adiconar portainer ao arquivo hosts
Adione ao arquivo /etc/hosts a seguinte linha, substituindo SEU_IP pelo IP da sua máquina, e não o 127.0.0.1. 
```
SEU_IP          portainer.docker.local
192.168.0.10    example.docker.local
```

Criar seus hosts virtuais dentro do diretorio /var/www/webdev/nginx/conf.d. Pois o mesmo já está mapeada no container em sua respectiva pasta.

### Configurar as variáveis de ambiente
Copie o arquivo de exemplo ([.env.example](.env.example)) e preencha as variáveis com seus valores.
Utilizamos o Blackfire para gerar profile. crie uma conta aqui <a href="https://blackfire.io/signup" target="_blank">https://blackfire.io/signup</a>
```
cp .env.example .env
```

### Subir o ambiente default
Por padrão é iniciado o Portainer, Nginx e o PHP
```sh
docker-compose up -d
```

Acesse seu navegador e digite https://portainer.docker.local

### Subir as demais feramentas
```sh
docker-compose -f blackfire/docker-compose-blackfire.yaml up -d
docker-compose -f elasticsearch/docker-compose-elasticsearch.yaml up -d
docker-compose -f freeswitch/docker-compose-freeswitch.yaml up -d
docker-compose -f postgres/docker-compose-postgres.yaml up -d
docker-compose -f rabbitmq/docker-compose-rabbitmq.yaml up -d
docker-compose -f redis/docker-compose-redis.yaml up -d
docker-compose -f redis/docker-compose-redisinsight.yaml up -d
```

### Alias para executar o PHP cli
Adicione, ao seu arquivo ~/.bashrc esta linha.
```sh
source /var/www/webdev/aliases.sh
```

PHP cli com xdebug3
```
php-8.0 -dxdebug.mode=debug index.php
```

Swoole com yasd
```
swoole-4.7 -e index.php
```