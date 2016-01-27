Instructions to build Bamboo
============================

1. Download bamboo code base.
2. Replace haproxy_template.cfg in bamboo's config directory.
3. docker login hub.dsra.local:5000
4. docker build -t hub.dsra.local:5000/dsra/bamboo:[VERSION]
5. docker push hub.dsra.local:5000/dsra/bamboo:[VERSION]
6. Use marathon configuration to deploy on all worker nodes.



