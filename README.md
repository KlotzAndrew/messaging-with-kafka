## Setup

Consumer group, needs 4 windows:

```shell
# window 1, start services and scale
docker-compose up
docker-compose scale kafka=3

# window 2, consumer a
ruby message_consumer_group.rb

# window 3, consumer b
ruby message_consumer_group.rb

# window 4, producer
ruby message_producer.rb 1
ruby message_producer.rb 0
```

### Managing commands
When error re-registering duplicate broker in zookeeper
```shell
bin/zkCli.sh

ls /brokers/ids
delete /brokers/ids # pick the duplicate id
```
