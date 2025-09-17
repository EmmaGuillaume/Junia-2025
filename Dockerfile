# Utilise l'image officielle de nginx comme base
FROM nginx

# Copie le code source de votre projet dans le répertoire par défaut de nginx
COPY . /usr/share/nginx/html

