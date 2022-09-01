require "http/web_socket"
require "option_parser"
require "base64"
require "http"

c = ""
user = ""
pass = ""

OptionParser.parse do |parser|
  parser.on "-h", "--help", "display help information" do
    puts parser
    exit
  end

	parser.on "-c", "--connect=<url>", "connect to a server" { |x| c = x }
  parser.on "-u", "--user=<username>", "configure basic auth with a username" { |x| user = x }
end

if c == ""
  puts "missing -c, --connect agument"
  exit
end

uri = URI.parse(c)
headers = HTTP::Headers.new
if user
  print "Enter password: "
  pass = STDIN.noecho &.gets.try &.chomp || ""

  b64 = Base64.encode("#{user}:#{pass}")
  headers["Authorization"] = "Basic #{b64.chomp}"
end

socket = HTTP::WebSocket.new(uri, headers)
puts "Connected. Press ctrl+c to exit."

spawn socket.run

socket.on_message do |msg|
  puts msg
end

loop do
  socket.send gets.not_nil!.chomp
end