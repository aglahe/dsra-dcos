# FROM mesosphere/mesos-dns
FROM argussecurity/mesos-dns:0.4.0
MAINTAINER Matt Parker <matthew.parker@l-3com.com>
ADD dsra-mesos-dns.json /config.json
EXPOSE 53
CMD ["/mesos-dns"]
