FROM php:8.2-apache

RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get update && apt-get install -y libicu-dev git zip \
    && pecl install xdebug \
	&& docker-php-ext-enable xdebug \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer