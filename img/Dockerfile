FROM ubuntu
MAINTAINER mickael@kerjean.me

RUN apt-get -y update && \
        mkdir -p /app/music && \
        #####################
        # INSTALL APPLICATION DEPS
        apt-get install -y git composer php-cli ffmpeg curl && \
        curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
        apt-get install -y nodejs && \
        npm install -g yarn && \
        apt-get install -y php-curl php-zip php-dom php-mysql php-mbstring && \
        #####################
        # INSTALL APPLICATION
        cd /app && \
        git clone https://github.com/phanan/koel code && \
        cd code && \
        git checkout v3.7.2 && \
        composer install && \
        #####################
        # INSTALL OTHER RELATED STUFF
        apt-get install -y mysql-client expect && \
        #####################
        # CLEANUP
        apt-get -y clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*    

EXPOSE 8000
VOLUME ["/app"]
WORKDIR "/app/music"    
ADD init.exp /app/init.exp
ADD entrypoint.sh /app/entrypoint.sh
CMD ["bash", "/entrypoint.sh"]