FROM ubuntu:20.04

LABEL maintainer="Danny Harding"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
&& apt-get install -y locales \
&& locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN apt-get update \
&& apt-get install -y gnupg curl zip unzip git supervisor sqlite3 software-properties-common nginx \
   libpng-dev libonig-dev libxml2-dev \
   && apt-get install -y php7.4-cgi php7.4-cli php7.4-fpm \
   php7.4-bcmath php7.4-bz2 php7.4-curl php7.4-dba php7.4-dev php7.4-enchant \
   php7.4-gd php7.4-gmp php7.4-imap php7.4-interbase php7.4-intl php7.4-json php7.4-ldap \
   php7.4-mbstring  php7.4-mysql php7.4-odbc php7.4-opcache php7.4-pgsql php7.4-phpdbg \
   php7.4-pspell php7.4-readline php7.4-snmp php7.4-soap php7.4-sqlite3 php7.4-sybase php7.4-tidy \
   php7.4-xml php7.4-xmlrpc php7.4-xsl php7.4-zip php-msgpack php-igbinary \
&& php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
&& mkdir -p /run/php \
&& apt-get -y autoremove \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& echo "daemon off;" >> /etc/nginx/nginx.conf

# && apt-get remove -y --purge software-properties-common \

# RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY default /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY start-container.sh /usr/bin/start-container

RUN chmod +x /usr/bin/start-container

ENTRYPOINT ["start-container"]
