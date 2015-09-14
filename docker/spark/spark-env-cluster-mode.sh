export MESOS_JAVA_NATIVE_LIBRARY=/usr/local/lib/libmesos.so
export SPARK_EXECUTOR_URI=http://hub.dsra.local:8088/dsra/repo/frameworks/spark-1.5.0-bin-hadoop2.6.tgz
export MASTER=zk://10.105.0.1:2181,10.105.0.3:2181,10.105.0.5:2181,10.105.0.7:2181,10.105.0.9:2181/mesos
