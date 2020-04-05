FROM java:latest

RUN mkdir -p /kafka/logs \
    && mkdir /kafka/scripts
COPY kafka_2.11-2.3.0.tgz /kafka
COPY entry-point.sh /kafka/scripts
WORKDIR /kafka
RUN chmod +x /kafka/scripts/entry-point.sh \
    && tar -xvf kafka_2.11-2.3.0.tgz \
    && sed -i "s/^#listener.security.protocol.map=.*$/listener.security.protocol.map=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT/" /kafka/kafka_2.11-2.3.0/config/server.properties \
    && cp /kafka/kafka_2.11-2.3.0/config/server.properties /kafka/kafka_2.11-2.3.0/config/server1.properties \
    && cp /kafka/kafka_2.11-2.3.0/config/server.properties /kafka/kafka_2.11-2.3.0/config/server2.properties \
    && sed -i "s/^#listeners=.*$/listeners=PLAINTEXT:\/\/kafka:9092,PLAINTEXT_HOST:\/\/localhost:29092/"  /kafka/kafka_2.11-2.3.0/config/server.properties \
    && sed -i "s/^#advertised.listeners=.*$/advertised.listeners=PLAINTEXT:\/\/kafka:9092,PLAINTEXT_HOST:\/\/localhost:29092/" /kafka/kafka_2.11-2.3.0/config/server.properties \
    && sed -i "s/^broker.id=.*$/broker.id=1/" /kafka/kafka_2.11-2.3.0/config/server1.properties \
    && sed -i "s/^log.dirs=.*$/log.dirs=\/tmp\/kafka1-logs/" /kafka/kafka_2.11-2.3.0/config/server1.properties \
    && sed -i "s/^#listeners=.*$/listeners=PLAINTEXT:\/\/kafka:9093,PLAINTEXT_HOST:\/\/localhost:29093/"  /kafka/kafka_2.11-2.3.0/config/server1.properties \
    && sed -i "s/^#advertised.listeners=.*$/advertised.listeners=PLAINTEXT:\/\/kafka:9093,PLAINTEXT_HOST:\/\/localhost:29093/" /kafka/kafka_2.11-2.3.0/config/server1.properties \
    && sed -i "s/^broker.id=.*$/broker.id=2/" /kafka/kafka_2.11-2.3.0/config/server2.properties \
    && sed -i "s/^log.dirs=.*$/log.dirs=\/tmp\/kafka2-logs/" /kafka/kafka_2.11-2.3.0/config/server2.properties \
    && sed -i "s/^#listeners=.*$/listeners=PLAINTEXT:\/\/kafka:9094,PLAINTEXT_HOST:\/\/localhost:29094/"  /kafka/kafka_2.11-2.3.0/config/server2.properties \
    && sed -i "s/^#advertised.listeners=.*$/advertised.listeners=PLAINTEXT:\/\/kafka:9094,PLAINTEXT_HOST:\/\/localhost:29094/" /kafka/kafka_2.11-2.3.0/config/server2.properties
WORKDIR /kafka/kafka_2.11-2.3.0/bin/
CMD /kafka/scripts/entry-point.sh
EXPOSE 9092 9093 9094 
