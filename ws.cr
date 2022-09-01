require "http/web_socket"
require "option_parser"

c = ""

OptionParser.parse do |parser|
  parser.on "-h", "--help", "display help information" do
    puts parser
    exit
  end

	parser.on "-c", "--connect=<url>", "connect to a server" { |x| c = x }
end

if c == ""
  puts "missing -c, --connect agument"
  exit
end

uri = URI.parse(c)
socket = HTTP::WebSocket.new(uri)
puts "Connected. Press ctrl+c to exit."

spawn socket.run

socket.on_message do |msg|
  puts msg
end

loop do
  socket.send gets.not_nil!.chomp
end