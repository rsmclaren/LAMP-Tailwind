# install node
FROM node:latest AS node

# install php
FROM php:8.2-apache

# copy nodejs binaries to php image
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
# create symlink for npm to the nodejs binary - allows npm to be run globally from the command line
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# install php extensions, enable xdebug and enable apache mod_rewrite
RUN apt-get update && apt-get install -y libicu-dev git zip \
    && pecl install xdebug \
    && docker-php-ext-install pdo pdo_mysql mysqli intl \
	  && docker-php-ext-enable xdebug \
    && a2enmod rewrite

# Install Composer and copy to php bin path, making it globally available
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
