FROM ubuntu:18.04
LABEL maintainer="Fabian Juette <fabian.juette@tu-clausthal.de>"

ENV DEBIAN_FRONTEND noninteractive
ENV BASEURL "http://localhost"

# Install basic system
RUN apt-get update && apt-get install -y \
software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
apache2 \
php7.2-gd \
php7.2-mysql \
php7.2-dev \
php7.2-dom \
php7.2-ldap \
php-mbstring \
php-zip \
libapache2-mod-php \
subversion
RUN apt-get install -y \
nano \
imagemagick
RUN apt-get install -y \
ghostscript \
antiword \
xpdf \
ffmpeg \
postfix \
libimage-exiftool-perl \
cron \
wget \
mysql-client

# Configure apache2
ADD rs-config.conf /etc/apache2/sites-available/000-default.conf
#RUN sed -i -e "s#DocumentRoot /var/www/html#DocumentRoot /var/www/resourcespace#g" /etc/apache2/sites-available/000-default.conf

# Configure php.ini
RUN cp -a /etc/php/7.2/apache2/php.ini /etc/php/7.2/apache2/php.ini-original
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1G/g" /etc/php/7.2/apache2/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 1G/g" /etc/php/7.2/apache2/php.ini
RUN sed -i -e "s/max_execution_time\s*=\s*30/max_execution_time = 1000/g" /etc/php/7.2/apache2/php.ini
RUN sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = 1G/g" /etc/php/7.2/apache2/php.ini

# Install resourcespace
WORKDIR /var/www
RUN mkdir resourcespace \
&& cd resourcespace \
&& svn co https://svn.resourcespace.com/svn/rs/releases/8.4 . \
&& mkdir filestore \
&& chmod 777 filestore \
&& chmod -R 777 include

ADD rs.sh /sbin
RUN chmod a+x /sbin/rs.sh

#TODO Add Cron Job from rs documentation

# Entrypoint
CMD ["/sbin/rs.sh"]
EXPOSE 80