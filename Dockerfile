FROM php:7.2-cli-alpine3.9

# Packages
RUN apk add --update \
    autoconf \
    build-base \
    linux-headers \
    libaio-dev \
    zlib-dev \
    curl \
    git \
    libevent-dev \
    openssl-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libtool \
    libbz2 \
    bzip2 \
    bzip2-dev \
    libstdc++ \
    libxslt-dev \
    openldap-dev \
    imagemagick-dev \
    make \
    unzip \
    wget && \
    docker-php-ext-install bcmath zip bz2 pdo_mysql mysqli simplexml opcache sockets mbstring pcntl xsl && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb && \
    pecl install event && \
    docker-php-ext-enable event && \
    mv /usr/local/etc/php/conf.d/docker-php-ext-event.ini \
    /usr/local/etc/php/conf.d/docker-php-ext-zz-event.ini && \
    pecl install swoole-4.3.5 && \
    docker-php-ext-enable swoole && \
    docker-php-ext-install gd && \
    docker-php-ext-enable opcache && \
    apk del build-base \
    linux-headers \
    libaio-dev \
    && rm -rf /var/cache/apk/*


ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_VERSION 1.8.4


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
 && composer --ansi --version --no-interaction

VOLUME /var/www
WORKDIR /var/www

CMD [ "php", "-v" ]
