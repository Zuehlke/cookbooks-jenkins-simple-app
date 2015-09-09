
#
# returns true if the given port is open, false otherwise
#
def port_open?(port)
  listen_ports = IO.popen('netstat -lnt').entries
  listen_ports.select { |e| e.split[3] =~ /:#{port}$/ }.any?
end

#
# returns the Net::HTTP response for doing a GET on the given url
#
def http_get(url)
  Chef::REST::RESTRequest.new(:GET, URI.parse(url), nil).call
end
