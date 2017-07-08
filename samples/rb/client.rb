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
  100.times do |i|
    # http://ruby-concurrency.github.io/concurrent-ruby/Concurrent/Promise.html
    p = Concurrent::Promise.execute do
      client.greeting(i)
    end
    print "#{i}\n"
  end
  sleep 1
  transport.close()
rescue Thrift::Exception => tx
  print 'Thrift::Exception: ', tx.message, "\n"
end
