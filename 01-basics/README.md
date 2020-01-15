# Pulsar Getting Started

## Overview
- [x] Install standalone Pulsar
- [x] Hello World producer and consumer
- [x] Benchmark

## Install and Run

### Locally

Install
```shell
wget https://archive.apache.org/dist/pulsar/pulsar-2.4.2/apache-pulsar-2.4.2-bin.tar.gz
tar xvf apache-pulsar-2.4.2-bin.tar.gz
cd apache-pulsar-2.4.2
```

Run
```shell
bin/pulsar standalone
```

### Docker
```shell
docker run -it \
  --name pulsar \
  -p 6650:6650 \
  -p 8080:8080 \
  -v $PWD/data:/pulsar/data \
  apachepulsar/pulsar:2.4.2 \
  bin/pulsar standalone
```

`alias pulsar-admin='docker exec -it pulsar bin/pulsar-admin'`

## Hello World

### Consumer

```shell
bin/pulsar-client consume persistent://public/default/hello-topic --subscription-name meetup --num-messages 0
```

### Producer

```shell
bin/pulsar-client produce persistent://public/default/hello-topic --messages "Kafka not the king" --messages "Pulsar rocks!" --messages "YES!"
```

## Benchmark

```shell
bin/pulsar-perf produce persistent://public/default/bench-topic --rate 10000
```

```shell
bin/pulsar-perf consume persistent://public/default/bench-topic --subscriber-name bench-subscription
```

Use `non-persistent` topic and watch the latency drops :)

### See topic stats

Persistent
```shell
bin/pulsar-admin persistent stats persistent://public/default/bench-topic
```

Non-persistent
```shell
bin/pulsar-admin non-persistent stats non-persistent://public/default/bench-topic
```