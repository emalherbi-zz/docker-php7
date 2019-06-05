FROM ubuntu:18.04
MAINTAINER Eduardo Malherbi <emalherbi@gmail.com>

ENV ACCEPT_EULA=Y
ENV TERM=xterm TZ=America/Sao_Paulo TZ=America/Sao_Paulo DEBIAN_FRONTEND=noninteractive

# update package list
RUN apt-get update

# install utils
RUN apt-get install -y curl git apt-utils 

# install apache
RUN apt-get install -y apache2

# install php
RUN apt-get install -y php7.2 mcrypt php-mbstring php-pear php7.2-dev php7.2-xml
RUN apt-get install -y libapache2-mod-php7.2

# install soap and curl and gd
RUN apt-get install -y libxml2-dev php-soap php-curl php-gd

# install mysql
RUN apt-get -y install php7.2-mysql --fix-missing

# install pre requisites
RUN apt-get install -y apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN apt-get install -y msodbcsql17 mssql-tools unixodbc-dev
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN exec bash

# install driver sqlsrv
RUN pecl install sqlsrv
RUN echo "extension=sqlsrv.so" >> /etc/php/7.2/apache2/php.ini

# install locales
RUN apt-get install -y locales && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# rewrite
RUN a2enmod rewrite

# 000-default.conf to change apache site settings
ADD 000-default.conf /etc/apache2/sites-available/

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]