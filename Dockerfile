# Dockerfile (image app: contient nginx + php-fpm)
FROM php:8.1-fpm

# Installer nginx et les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    unzip \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

# Copier la configuration Nginx
COPY docker/nginx-default.conf /etc/nginx/sites-available/default

# Copier le code source dans /var/www/html
COPY . /var/www/html

# Donner les bonnes permissions
RUN chown -R www-data:www-data /var/www/html

# Exposer le port 80
EXPOSE 80

# Lancer php-fpm en arrière-plan et nginx au premier plan
CMD ["bash", "-c", "service php8.1-fpm start && nginx -g 'daemon off;'"]
