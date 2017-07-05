require 'bundler'
$:.push('gen-rb')
Bundler.require :default
require 'base_service'

PORT = ARGV[0] || 9090
HOST = 'localhost'

begin
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new(HOST, PORT))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = Base::BaseService::Client.new(protocol)
  transport.open()
  response = client.greeting(false)
  print "#{response}\n"
  transport.close()
rescue Thrift::Exception => tx
  print 'Thrift::Exception: ', tx.message, "\n"
end
