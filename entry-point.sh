#!/bin/bash

if [ -z "$CASSANDRA_HOST" ]; then
    echo "\$CASSANDRA_HOST is not set, using the default name (cassandra)"
    host="cassandra"
else
    echo "Setting storage.hostname=$CASSANDRA_HOST"
    sed -i "s/storage.hostname=cassandra/storage.hostname=$CASSANDRA_HOST/" /srv/titan-1.0.0-hadoop1/conf/titan-cassandra-es.properties
    host=$CASSANDRA_HOST
fi

echo $CASSANDRA_USERNAME
if [ -z "$CASSANDRA_USERNAME" ]; then
    echo "\$CASSANDRA_USERNAME is not set, using the default username (cassandra)"
else
    echo "Setting storage.username=$CASSANDRA_USERNAME"
    sed -i "s/storage.username=cassandra/storage.username=$CASSANDRA_USERNAME/" /srv/titan-1.0.0-hadoop1/conf/titan-cassandra-es.properties
fi

if [ -z "$CASSANDRA_PASSWORD" ]; then
    echo "\$CASSANDRA_PASSWORD is not set, using the default password (cassandra)"
else
    echo "Setting storage.password=$CASSANDRA_PASSWORD"
    sed -i "s/storage.password=cassandra/storage.password=$CASSANDRA_PASSWORD/" /srv/titan-1.0.0-hadoop1/conf/titan-cassandra-es.properties
fi

if [ -z "$ELASTICSEARCH_HOST" ]; then
    echo "\$ELASTICSEARCH_HOST is not set, using the default name (es)"
else
    echo "Setting index.search.hostname=$ELASTICSEARCH_HOST"
    sed -i "s/index.search.hostname=es/index.search.hostname=$ELASTICSEARCH_HOST/" /srv/titan-1.0.0-hadoop1/conf/titan-cassandra-es.properties
fi

seconds=0
timeout=60
echo -n "Waiting for cassandra. "
while [ "$seconds" -lt "$timeout" ] && ! nc -z -w1 $host 9042
do
    echo -n "."
    seconds=$((seconds+1))
    sleep 1
done

if [ "$seconds" -lt "$timeout" ]; then
    echo "up!"
else
    echo "ERR: unable to connect"
    exit 1
fi

exec $@
