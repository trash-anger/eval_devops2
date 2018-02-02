FROM debian:stretch-slim
MAINTAINER Alexandre MORAT <alexandre.morat@apcm.ovh>

RUN echo "deb http://deb.debian.org/debian/ stretch main" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nginx-common=1.10* libnginx-mod-http-echo=1.10* libssl1.1=1.1* nginx-light=1.10*
COPY default /etc/nginx/sites-available/default
COPY index.php /var/www/html/index.php
COPY insert.php /var/www/html/insert.php
COPY show.php /var/www/html/show.php

VOLUME ["/var/www/html"]

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
