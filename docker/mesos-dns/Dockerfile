FROM mesosphere/mesos-dns
MAINTAINER Matt Parker <matthew.parker@l-3com.com>
ADD dsra.json /
EXPOSE 53
CMD ["/mesos-dns", "config=dsra.json"]
