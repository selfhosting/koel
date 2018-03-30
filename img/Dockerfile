FROM ubuntu
MAINTAINER mickael@kerjean.me

RUN apt-get -y update && \
        mkdir /app && cd /app && \
        #####################
        # INSTALL DEPENDENCIES
        apt-get install -y composer php-cli apache2 libapache2-mod-php git ffmpeg curl && \
        curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
        apt-get install -y nodejs && \
        npm install -g yarn && \
        apt-get install -y php-curl php-zip php-dom php-mysql php-mbstring && \
        #####################
        # INSTALL APPLICATION
        git clone https://github.com/phanan/koel code && \
        cd code && \
        git checkout v3.7.2 && \
        composer install && \
        #####################
        # CONFIGURATION
        sed -i 's|DocumentRoot.*|DocumentRoot /app/code|' /etc/apache2/sites-available/000-default.conf && \
        sed -i 's|/var/www|/app/code|' /etc/apache2/apache2.conf && \
        sed -i 's|AllowOverride None|AllowOverride All|' /etc/apache2/apache2.conf && \
        a2enmod rewrite && \
        echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf && \
        a2enconf servername && \
        chown -R www-data:www-data /app && \
        #####################
        # INSTALL OTHER RELATED STUFF
        apt-get install -y mysql-client expect && \
        #####################
        # CLEANUP
        apt-get -y clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*    

EXPOSE 80
VOLUME ["/app"]
WORKDIR "/app/"    
ADD init.exp /app/init.exp
ADD entrypoint.sh /app/entrypoint.sh
CMD ["bash", "/app/entrypoint.sh"]

