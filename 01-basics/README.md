# Pulsar Getting Started

## Overview

- [x] Install standalone Pulsar
- [x] Hello World producer and consumer
- [x] Benchmark

## Install and Run

### Locally

Install

```shell
PULSAR_VERSION=3.0.3
wget https://archive.apache.org/dist/pulsar/pulsar-$PULSAR_VERSION/apache-pulsar-$PULSAR_VERSION-bin.tar.gz
tar xvf apache-pulsar-$PULSAR_VERSION-bin.tar.gz
cd apache-pulsar-$PULSAR_VERSION
```

Run

```shell
pulsar standalone
```

Note to run on a different port update port 6650 and 8080 in `conf/standalone.conf` and run with

`pulsar standalone --zookeeper-port 2182 --bookkeeper-port 3182 --stream-storage-port 4182`


### Docker

```shell
docker run -it \
  --name pulsar \
  -p 6650:6650 \
  -p 8080:8080 \
  -v $PWD/data:/pulsar/data \
  apachepulsar/pulsar-all:3.0.3 \
  bin/pulsar standalone
```

`alias pulsar-admin='docker exec -it pulsar pulsar-admin'`

## Hello World

### Consumer

```shell
pulsar-client consume persistent://public/default/hello-topic --subscription-name meetup --num-messages 0
```

### Producer

```shell
pulsar-client produce persistent://public/default/hello-topic --messages "Kafka not the king" --messages "Pulsar rocks!" --messages "YES!"
```

## Benchmark

```shell
pulsar-perf produce persistent://public/default/bench-topic --rate 1000
```

```shell
pulsar-perf consume persistent://public/default/bench-topic --subscriber-name bench-subscription
```

Use `non-persistent` topic and watch the latency drops :)

### See topic stats

Persistent

```shell
pulsar-admin persistent stats persistent://public/default/bench-topic
```

Non-persistent

```shell
pulsar-admin non-persistent stats non-persistent://public/default/bench-topic
```