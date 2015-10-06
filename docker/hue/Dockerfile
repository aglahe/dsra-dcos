FROM logbase/hue:latest
MAINTAINER Matt Parker <matthew.parker@l3-com.com>

COPY hue.ini /local/git/hue/desktop/conf.dist/hue.ini

#COPY hue.ini /local/git/hue/desktop/conf/hue.ini
#COPY hue.ini /etc/hue/hue.ini
#COPY hue.ini /local/git/hue/desktop/conf/hue.ini
#COPY hue.ini desktop/conf/pseudo-distributed.ini
#COPY hue.ini /local/git/hue/desktop/conf.dist/hue.ini
# COPY pseudo-distributed.ini > /local/git/hue/desktop/conf/pseudo-distributed.ini

EXPOSE 50070
EXPOSE 8020

CMD ["build/env/bin/supervisor"]
