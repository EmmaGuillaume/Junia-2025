# Dockerfile (image app: contient nginx + php-fpm)
FROM php:8.1-fpm

# installer nginx et utilitaires
RUN docker-php-ext-install pdo pdo_mysql
RUN apt-get update && apt-get install -y nginx git unzip \
    && rm -rf /var/lib/apt/lists/*

# config nginx (on remplace le site par défaut)
COPY docker/nginx-default.conf /etc/nginx/sites-available/default

# copier le code dans /var/www/html
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

# lancer php-fpm en arrière-plan et nginx au premier plan
CMD ["bash", "-c", "php-fpm -F & nginx -g 'daemon off;'"]



