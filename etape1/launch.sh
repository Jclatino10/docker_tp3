# Création du réseau Docker
docker network create tp3net1

# Suppression des anciens containers
docker rm -f http script 

# Lancement du container PHP-FPM
docker run -d --name script --network tp3net1 -v "$PWD/src:/app" php:8.3-fpm

# Lancement du container Nginx et exposition du port 8080
docker run -d --name http --network tp3net1 -p 8080:80 -v "$PWD/src:/app" -v "$PWD/config/default.conf:/etc/nginx/conf.d/default.conf:ro" nginx:1.29
