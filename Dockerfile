FROM ubuntu:jammy

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_VERSION 3.3.6
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_OPTS -Djava.library.path=/usr/local/hadoop/lib/native
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV YARN_RESOURCEMANAGER_USER root
ENV YARN_NODEMANAGER_USER root

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
        wget libzip4 libsnappy1v5 libssl-dev openjdk-8-jdk openssh-client \
    && wget https://dlcdn.apache.org/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && apt remove -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && tar -zxf /hadoop-$HADOOP_VERSION.tar.gz \
    && rm /hadoop-$HADOOP_VERSION.tar.gz \
    && mv hadoop-$HADOOP_VERSION /usr/local/hadoop \
    && mkdir -p /usr/local/hadoop/logs

COPY docker/config $HADOOP_HOME/etc/hadoop/

RUN mkdir -p /data/dfs/data /data/dfs/name /data/dfs/namesecondary \
    && hdfs namenode -format
VOLUME /data

COPY docker/start-yarn.sh /usr/local/bin/start-yarn.sh
RUN chmod +x /usr/local/bin/start-yarn.sh

EXPOSE 22 9000 9870 9866 9867 9864 9868 8088

CMD ["hdfs"]
