require 'kafka'

# logger = Logger.new(STDOUT)

partition_value = ARGV[0] || '0'
topic = 'greetings'
msg = 'Hello, World!'

kafka = Kafka.new(
  # At least one of these nodes must be available:
  # seed_brokers: ['kafka:9092'],
  seed_brokers: ['http://192.168.99.100:9092'],

  # Set an optional client id in order to identify the client to Kafka:
  client_id: 'my-application',
  # logger: logger
)

partitions = kafka.partitions_for(topic)

partition = partition_value.to_i % partitions

kafka.deliver_message(msg, topic: topic, partition: partition)

producer = kafka.producer(required_acks: :all)
producer.produce('Async Hello!', topic: topic, partition: partition)
producer.deliver_messages
producer.shutdown
