#!/usr/bin/env python3

import pulsar

# handle Ctrl+C
import signal
signal.signal(signal.SIGINT, signal.SIG_DFL)

client = pulsar.Client('pulsar://localhost:6650')

# Subscription type is Shared (i.e. Queue semantic) to work with DelayedDelivery
consumer = client.subscribe('persistent://public/default/schema-topic', 'schema-consumer-subscription', consumer_type=pulsar.ConsumerType.Shared)

while True:
    msg = consumer.receive()
    print("Received message '%s' id='%s'" % (msg.data().decode('utf-8'), msg.message_id()))
    consumer.acknowledge(msg)

client.close()