ARG SITE_PHP_VERSION

FROM php:${SITE_PHP_VERSION}-alpine

RUN apk add --update $PHPIZE_DEPS libpng-dev libjpeg-turbo-dev libwebp-dev pngquant mysql-client mariadb-connector-c-dev \
    && pecl install -o -f redis \
    && apk del $PHPIZE_DEPS \
    && rm -rf /tmp/pear
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && docker-php-ext-configure gd --with-jpeg --with-webp \
    && docker-php-ext-install pdo_mysql exif pcntl gd opcache \
    && docker-php-ext-enable redis
