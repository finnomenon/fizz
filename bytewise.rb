require 'socket'

socket = TCPServer.new 8000

loop do

teststring = ""

  client = socket.accept
  while client.recv(50) != ""
   teststring << client.recv(50)
  end
  puts teststring
end
