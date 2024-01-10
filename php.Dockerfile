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

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN groupadd -g ${GID} php && \
    useradd -g php -u ${UID} -s /bin/sh -m php

RUN sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=php/g' /etc/apache2/envvars
RUN sed -i 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=php/g' /etc/apache2/envvars

USER php

# Install Composer and copy to php bin path, making it globally available
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
