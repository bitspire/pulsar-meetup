# Simple Pulsar Function Processor

First go to processor project to build the jar

Create function

```shell
pulsar-admin functions create --name WordsLength --tenant public --namespace default --jar examples/app.jar --classname ca.bitspire.meetup.pulsar.ProcessorFunction --inputs persistent://public/default/words --output persistent://public/default/words-length --window-length-count 3

# Or with time window
pulsar-admin functions create --name WordsLength --tenant public --namespace default --jar examples/app.jar --classname ca.bitspire.meetup.pulsar.ProcessorFunction --inputs persistent://public/default/words --output persistent://public/default/words-length --window-length-duration-ms 10000
```

Delete function

```shell
pulsar-admin functions delete --name WordsLength
```

Check if function running

```shell
pulsar-admin functions status --name WordsLength --tenant public --namespace default
```

Note: if not running, check broker logs ./logs/functions/public/default/WordsLength 

## Test The Function

Run a consumer

```shell
pulsar-client consume persistent://public/default/words-length --subscription-name words-subscription --num-messages 0
```

Produce words

```shell
pulsar-client produce persistent://public/default/words --messages "Kafka not the king" --messages "Pulsar rocks!" --messages "YES!"
```

The consumer should show `35` which is the sum of all letters in the 3 messages

