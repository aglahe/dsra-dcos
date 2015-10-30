FROM aarongdocker/hdfs
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

# Setup env
USER root
ENV HADOOP_USER httpfs

# Copy the httpfs-site file to add Hue
WORKDIR /usr/local/hadoop
COPY httpfs-site.xml etc/hadoop/httpfs-site.xml

# Add HADOOP_USER and setup permissions and ownership
RUN groupadd -r $HADOOP_USER && useradd -r -g $HADOOP_USER -G hadoop $HADOOP_USER \
&& chown -R $HADOOP_USER:hadoop /usr/local/hadoop/

#Ports: WebHDFS
EXPOSE 14000

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh

USER $HADOOP_USER
ENTRYPOINT ["/bin/bootstrap.sh"]
CMD ["bash"]
