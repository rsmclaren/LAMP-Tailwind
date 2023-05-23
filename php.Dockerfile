FROM php:8.2-apache

RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get update && apt-get install -y \
    && pecl install xdebug \
	&& docker-php-ext-enable xdebug \
    && a2enmod rewrite
