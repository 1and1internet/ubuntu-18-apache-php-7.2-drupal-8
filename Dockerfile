FROM 1and1internet/ubuntu-18-apache-php-7.2:latest
MAINTAINER brian.wilkinson@1and1.co.uk
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
ENV DRUPAL_DB_HOST=mysql \
    DRUPAL_DB_PORT=3306 \
    DRUPAL_DB_USER=drupal \
    DRUPAL_DB_NAME=drupal \
    DRUPAL_DB_PASSWORD=EnvVarHere \
    DRUPAL_DB_DRIVER=mysql \
    DRUPAL_DB_PREFIX=''
RUN \
    apt-get update && apt-get install -y php-uploadprogress libpng-dev libjpeg-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/* && \
    DRUPAL_VERSION=$(curl -fs https://ftp.drupal.org/files/projects/ | grep  -Eo 'drupal-8.[0-9]+.[0-9]+.tar.gz' | sort -nr | head -1) && \
    echo "Pulling $DRUPAL_VERSION" && \
    curl -fSL "https://ftp.drupal.org/files/projects/${DRUPAL_VERSION}" -o /usr/src/drupal.tar.gz && \
    chmod -R 755 /hooks /init
