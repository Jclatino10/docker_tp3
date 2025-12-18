docker network create tp3net2
docker rm -f http script data
docker run -d --name data --network tp3net2 -e MARIADB_RANDOM_ROOT_PASSWORD=1 -v "$PWD/sql:/docker-entrypoint-initdb.d" mariadb:11
docker build -t tp3-php-mysqli ./script
docker run -d --name script --network tp3net2 -v "$PWD/src:/app" tp3-php-mysqli
docker run -d --name http --network tp3net2 -p 8080:80 -v "$PWD/src:/app" -v "$PWD/config/default.conf:/etc/nginx/conf.d/default.conf:ro" nginx:1.29
