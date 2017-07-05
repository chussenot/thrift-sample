require 'bundler'
$:.push('gen-rb')
Bundler.require :default
require 'base_service'

class Handler
  def initialize()
    @log = {}
  end

  def greeting(english=true)
    puts "greeting()"
    "hello world"
  end
end

handler = Handler.new()
processor = Base::BaseService::Processor.new(handler)
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::SimpleServer.new(processor, transport, transportFactory)

puts "Starting the server..."
server.serve()
puts "done."
