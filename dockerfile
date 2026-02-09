FROM php:8.4-apache

RUN apt update

RUN apt install -y nano zip

RUN docker-php-ext-install mysqli

WORKDIR /

RUN curl https://ftp.drupal.org/files/projects/drupal-10.3.2.zip --output drupal.zip

RUN unzip drupal.zip

RUN mv drupal-*/* /var/www/html/
