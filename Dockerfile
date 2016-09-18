FROM hypriot/rpi-alpine-scratch:v3.4


RUN apk add --no-cache lighttpd \
                       # alpine wiki for lighttpd with php
                       php5-common php5-iconv php5-json php5-gd php5-curl php5-xml php5-pgsql php5-imap php5-cgi fcgi \
                       php5-pdo php5-pdo_pgsql php5-soap php5-xmlrpc php5-posix php5-mcrypt php5-gettext php5-ldap php5-ctype php5-dom \
                       # for https download with wget
                       openssl \
                       # full tar version including --strip option
                       tar \
                       # php calendar extension
                       php5-calendar
 
# activate php for lighttpd
# lighttpd needs a directory to store unix socket file (which is not created by default)
RUN mkdir /run/lighttpd && \
    chown lighttpd:lighttpd /run/lighttpd && \
    # activate fastcgi
    sed -e "s/#   include \"mod_fastcgi.conf\"/include \"mod_fastcgi.conf\"/" < /etc/lighttpd/lighttpd.conf > /etc/lighttpd/lighttpd.conf

# download davical and awl (a dependency of davical)
RUN wget "https://gitlab.com/davical-project/awl/repository/archive.tar.gz?ref=r0.56" -O awl.tar.gz && \
    mkdir /awl && \
    tar -xf awl.tar.gz --strip 1 -C /awl && \
    rm awl.tar.gz && \
    # put the awl library int php's include path
    sed -e "s/;include_path = \".:\/php\/includes\"/include_path = \".:\/awl\/inc\"/" < /etc/php5/php.ini > /etc/php5/php.ini && \
    chown lighttpd:lighttpd -R /awl && \
    wget "https://gitlab.com/davical-project/davical/repository/archive.tar.gz?ref=r1.1.4" -O davical.tar.gz && \
    rm -r /var/www/localhost/* && \
    tar -xf davical.tar.gz --strip 1 -C /var/www/localhost/ && \
    rm davical.tar.gz

# these variables are used by the entrypoint to generate the davical configuration
ENV DB_HOST db
ENV DB_PORT 5432
ENV DB_NAME davical
ENV DB_USER davical_app
ENV DB_PASS 53cret
ENV DEFAULT_LOCALE en_EN.UTF-8

COPY docker-entrypoint.sh /docker-entrypoint.sh 

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
