
Add connectors


```shell
mkdir <PULSAR_HOME>/connectors
cd connectors
wget https://archive.apache.org/dist/pulsar/pulsar-2.4.2/connectors/pulsar-io-jdbc-2.4.2.nar
```


Run MySQL ([docs](https://pulsar.apache.org/docs/en/io-quickstart/#connect-pulsar-to-mysql))

```shell
docker run -d -it --rm \
--name pulsar-mysql \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=jdbc \
-e MYSQL_USER=mysqluser \
-e MYSQL_PASSWORD=mysqlpw \
mysql:5.7
```

Create DB
```shell
docker exec -it pulsar-mysql /bin/bash
mysql -h localhost -uroot -pjdbc
```

```sql
create database pulsar_mysql_jdbc_sink;

use pulsar_mysql_jdbc_sink;

create table if not exists user
(
id INT AUTO_INCREMENT,
age INT,
name VARCHAR(255) NOT NULL,
primary key (id)
)
engine=innodb;
```

JDBC Sink configuration

PULSAR_HOME/connectors/user-jdbc-sink.yaml
```yaml
configs:
  userName: "root"
  password: "jdbc"
  jdbcUrl: "jdbc:mysql://127.0.0.1:3306/pulsar_mysql_jdbc_sink"
  tableName: "user"
```

Avro Schema

PULSAR_HOME/connectors/avro-schema
```json
{
  "type": "AVRO",
  "schema": "{\"type\":\"record\",\"name\":\"User\",\"fields\":[{\"name\":\"id\",\"type\":[\"null\",\"int\"]},{\"name\":\"age\",\"type\":[\"null\",\"int\"]},{\"name\":\"name\",\"type\":[\"null\",\"string\"]}]}",
  "properties": {}
}

```

Attach schema to topic
```shell
bin/pulsar-admin schemas upload user-mysql-jdbc-sink-topic -f ./connectors/avro-schema
```

Create JDBC sink

```shell
bin/pulsar-admin sinks create \
--archive ./connectors/pulsar-io-jdbc-2.4.2.nar \
--inputs user-mysql-jdbc-sink-topic \
--name user-mysql-jdbc-sink \
--sink-config-file ./connectors/user-jdbc-sink.yaml \
--parallelism 1
```

Check that the sink is running

```shell
bin/pulsar-admin sinks status \
--tenant public \
--namespace default \
--name user-mysql-jdbc-sink
```

Some useful commands to work with schema

Get schema
```shell
bin/pulsar-admin schemas get user-mysql-jdbc-sink-topic
```

Delete topic schema (very useful to resolve schema incompatibility error)

```shell
bin/pulsar-admin schemas delete user-mysql-jdbc-sink-topic
```
