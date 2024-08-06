FROM wordpress:php7.4-apache

# install extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions calendar
RUN install-php-extensions ffi
RUN install-php-extensions gettext
RUN install-php-extensions igbinary
RUN install-php-extensions memcache
RUN install-php-extensions memcached
RUN install-php-extensions msgpack
RUN install-php-extensions pcov
RUN install-php-extensions pdo_mysql
RUN install-php-extensions redis
RUN install-php-extensions shmop
RUN install-php-extensions sockets
RUN install-php-extensions sysvmsg
RUN install-php-extensions sysvsem
RUN install-php-extensions sysvshm
RUN install-php-extensions tidy

# Install ImageMagick
RUN apt-get update && apt-get install -y libmagickwand-dev

# Install and enable imagick
RUN pecl install imagick && docker-php-ext-enable imagick

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod vhost_alias

# Set recommended PHP settings
# COPY ./custom.ini /usr/local/etc/php/conf.d/custom.ini

# Copy custom virtual host configuration
# COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]