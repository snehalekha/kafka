/kafka/kafka_2.11-2.3.0/bin/zookeeper-server-start.sh /kafka/kafka_2.11-2.3.0/config/zookeeper.properties >/kafka/logs/zookeeper.log 2>&1 &
/kafka/kafka_2.11-2.3.0/bin/kafka-server-start.sh /kafka/kafka_2.11-2.3.0/config/server.properties >/kafka/logs/kafka.log 2>&1 &
tail -f /dev/null