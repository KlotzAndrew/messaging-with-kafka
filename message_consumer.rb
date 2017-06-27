require 'kafka'

# logger = Logger.new(STDOUT)

kafka = Kafka.new(
  # At least one of these nodes must be available:
  # seed_brokers: ['kafka:9092'],
  seed_brokers: ['http://192.168.99.100:9092'],

  # Set an optional client id in order to identify the client to Kafka:
  client_id: 'my-application',
  # logger: logger
)
# partitions = kafka.partitions_for('greetings')

kafka.each_message(topic: 'greetings') do |message|
  puts "Received: #{message.offset}, #{message.key}, #{message.value}"
end
