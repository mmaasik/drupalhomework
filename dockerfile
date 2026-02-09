FROM php:8.4-apache

RUN apt update \
 && apt install -y nano zip unzip curl libpng-dev libjpeg-dev libfreetype6-dev libzip-dev \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install pdo pdo_mysql zip gd \
 && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

WORKDIR /var/www/html

RUN curl -fSL https://ftp.drupal.org/files/projects/drupal-10.3.2.zip -o drupal.zip \
 && unzip drupal.zip \
 && mv drupal-*/* . \
 && rm -rf drupal-* drupal.zip

RUN cp sites/default/default.settings.php sites/default/settings.php \
 && mkdir -p sites/default/files \
 && chown -R www-data:www-data /var/www/html \
 && find /var/www/html -type d -exec chmod 755 {} \; \
 && find /var/www/html -type f -exec chmod 644 {} \;
