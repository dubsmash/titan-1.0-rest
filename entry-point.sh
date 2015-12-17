#!/bin/bash

if [ -z "$CASSANDRA_HOST" ]; then
    echo "\$CASSANDRA_HOST is not set, using the default name (cassandra)"
else
    echo "Setting storage.hostname=$CASSANDRA_HOST"
    sed -i "s/storage.hostname=cassandra/storage.hostname=$CASSANDRA_HOST/" /srv/titan-1.0.0-hadoop1/conf/titan-cassandra-es.properties
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

exec $@
