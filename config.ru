require "rubygems"
require 'rack/contrib'
require 'rack-rewrite'
require 'rack/reverse_proxy'

use Rack::Static, :root => "web"
use Rack::Rewrite do
  rewrite '/', '/index.html'
end

use Rack::ReverseProxy do
  # Forward the path /test* to http://example.com/test*
  reverse_proxy '/cityment', 'http://grepsy.cloudant.com/'
end

run Rack::Directory.new('web')