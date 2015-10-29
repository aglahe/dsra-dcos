FROM hub.dsra.local:5000/cloudera/hue:3.9.0
MAINTAINER Matt Parker <matthew.parker@l3-com.com>

# Copy the hue template
COPY hue.ini.template /tmp/hue.ini.template

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh

USER hue
ENTRYPOINT ["/bin/bootstrap.sh"]
CMD ["bash"]
