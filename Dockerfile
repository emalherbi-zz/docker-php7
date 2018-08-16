FROM ubuntu:16.04
MAINTAINER Eduardo Malherbi <emalherbi@gmail.com>

ENV ACCEPT_EULA=Y

# update package list
RUN apt-get update

# install utils
RUN apt-get install -y curl git apt-utils 

# install apache
RUN apt-get install -y apache2

# install php
RUN apt-get update
RUN apt-get install -y php7.0 mcrypt php7.0-mcrypt php-mbstring php-pear php7.0-dev php7.0-xml
RUN apt-get install -y libapache2-mod-php7.0

# install mysql
RUN apt-get update
RUN apt-get -y install php7.0-mysql --fix-missing

# install pre requisites
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN apt-get install -y msodbcsql mssql-tools
RUN apt-get install -y unixodbc-utf16
RUN apt-get install -y unixodbc-dev-utf16

# install driver sqlsrv
RUN pecl install sqlsrv
RUN echo "extension=sqlsrv.so" >> /etc/php/7.0/apache2/php.ini

# load driver sqlsrv
RUN echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/apache2/php.ini
RUN echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/cli/php.ini

# install ODBC Driver
RUN apt-get install -y msodbcsql mssql-tools unixodbc-dev
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN exec bash

# install locales
RUN apt-get install -y locales && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

EXPOSE 80
EXPOSE 443

# 000-default.conf to change apache site settings.
ADD 000-default.conf /etc/apache2/sites-available/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]