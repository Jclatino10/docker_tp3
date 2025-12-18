# Création du réseau Docker
docker network create tp3net2

# Suppression des anciens containers
docker rm -f http script data

# Lancement du container MariaDB avec initialisation SQL
docker run -d --name data --network tp3net2 -e MARIADB_RANDOM_ROOT_PASSWORD=1 -v "$PWD/sql:/docker-entrypoint-initdb.d" mariadb:11

# Construction de l’image PHP avec mysqli
docker build -t tp3-php-mysqli ./script

# Lancement du container PHP-FPM avec mysqli
docker run -d --name script --network tp3net2 -v "$PWD/src:/app" tp3-php-mysqli

# Lancement du container Nginx
docker run -d --name http --network tp3net2 -p 8080:80 -v "$PWD/src:/app" -v "$PWD/config/default.conf:/etc/nginx/conf.d/default.conf:ro" nginx:1.29
