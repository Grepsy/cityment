require 'cityment/api'
require 'cityment/xml'
require 'cityment/sourcedir'

module Cityment
  def fetch_sample
    resp = API.fetch
    XML::SourceDocument.parse resp.body
  end
  
  def crawl_source
    resp = API.fetch({:laterthan => '2011-01-01', :num => 200})
    doc = XML::SourceDocument.parse resp.body

  end
  
end

include Cityment