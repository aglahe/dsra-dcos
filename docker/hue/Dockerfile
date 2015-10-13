FROM logbase/hue:latest
MAINTAINER Matt Parker <matthew.parker@l3-com.com>

# COPY hue.ini /etc/hue/hue.ini
copy hue.ini /local/git/hue/desktop/conf/pseudo-distributed.ini
#copy hue.ini /local/git/hue/desktop/conf.dist/hue.ini

#EXPOSE 50070
#EXPOSE 8020

#RUN adduser hue

CMD ["build/env/bin/hue","runserver","0.0.0.0:8000"]
# CMD ["build/env/bin/supervisor"]
