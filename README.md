# Ambiente de desenvolvimento PHP

Clone este projeto dentro de /var/www

### Criar as Imagens
```shell script
docker build -f 5.6/Dockerfile -t webdev:5.6-fpm 5.6/
docker build -f 7.0/Dockerfile -t webdev:7.0-fpm 7.0/
docker build -f 7.1/Dockerfile -t webdev:7.1-fpm 7.1/
docker build -f 7.2/Dockerfile -t webdev:7.2-fpm 7.2/
docker build -f 7.3/Dockerfile -t webdev:7.3-fpm 7.3/
docker build -f 7.4/Dockerfile -t webdev:7.4-fpm 7.4/
```

### Alias para executar o PHP cli
Adicione, ao seu arquivo ~/.bashrc esta linha.
```shell script
source /var/www/webdev/aliases.sh
```

### Adiconar portainer ao arquivo hosts
Adione ao arquivo /etc/hosts a seguinte linha, substituindo SEU_IP pelo IP da sua máquina, e não o 127.0.0.1. 
```
SEU_IP          portainer.docker.local
192.168.0.10    example.docker.local
```

Criar seus hosts virtuais dentro do diretorio /var/www/webdev/nginx/conf.d. Pois o mesmo já está mapeada no container em sua respectiva pasta.


### Subir o ambiente
```shell script
docker-compose up -d
```

Acesse seu navegador e digite https://portainer.docker.local

### Baixar o ambiente
```shell script
docker-compose down
```
