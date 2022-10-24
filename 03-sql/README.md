# Pulsar SQL

After running all previous examples, we can explore the data with SQL

Run pulsar sql worker (presto/trino)

```shell
pulsar sql-worker run
```

Start pulsar sql shell

```shell
pulsar sql
```

```shell
show tables in pulsar."public/default";

select * from pulsar."public/default"."hello-topic";

select * from pulsar."public/default".words;

```
