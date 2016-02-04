# Set the pythong shell to use ipython
export PYSPARK_DRIVER_PYTHON=ipython

# Location of Hadoop conf for the Driver
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop

# Location of the MESOS Library
export MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so

# Where the Spark Dist lives
export SPARK_EXECUTOR_URI=hdfs://dsra/user/spark/dist/spark-1.6.0-bin-2.6.0.tgz
