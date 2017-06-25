require 'kafka'

logger = Logger.new(STDOUT)

kafka = Kafka.new(
  # At least one of these nodes must be available:
  # seed_brokers: ['kafka:9092'],
  seed_brokers: ['http://192.168.99.100:9092'],

  # Set an optional client id in order to identify the client to Kafka:
  client_id: 'my-application',
  # logger: logger
)

kafka.deliver_message('Hello, World!', topic: 'greetings')

producer = kafka.producer(required_acks: :all)
producer.produce('Async Hello!', topic: 'greetings')
producer.deliver_messages
producer.shutdown
