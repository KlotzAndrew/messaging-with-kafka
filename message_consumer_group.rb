require 'kafka'

# logger = Logger.new(STDOUT)

kafka = Kafka.new(
  # At least one of these nodes must be available:
  # seed_brokers: ['kafka:9092'],
  seed_brokers: [
    'http://192.168.99.100:9092',
    'http://192.168.99.100:9093',
    'http://192.168.99.100:9094'
  ],

  # Set an optional client id in order to identify the client to Kafka:
  client_id: 'my-application',
  # logger: logger
)
partitions = kafka.partitions_for('greetings')

puts "# of partitions: #{partitions}"

consumer = kafka.consumer(group_id: 'my-consumer')

consumer.subscribe('greetings')

consumer.each_message do |message|
  puts '#####'
  puts "topic: #{message.topic}, partition:#{message.partition}"
  puts "offset: #{message.offset}, key: #{message.key}, value: #{message.value}"
end
