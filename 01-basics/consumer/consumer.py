#!/usr/bin/env python

import pulsar

client = pulsar.Client('pulsar://localhost:6650')
consumer = client.subscribe('persistent://public/default/hello-topic', 'consumer-subscription')

while True:
    msg = consumer.receive()
    print("Received message '%s' id='%s'" % (msg.data().decode('utf-8'), msg.message_id()))
    consumer.acknowledge(msg)

client.close()