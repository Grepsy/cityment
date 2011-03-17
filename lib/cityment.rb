require 'cityment/api'
require 'cityment/xml'
require 'cityment/xml/pox'

module Cityment
  def fetch_sample
    resp = API.fetch
    XML::POX::SourceDocument.parse resp.body
  end
  
  # def crawl_source maxage = '2011-01-01'
  #   srcdir = SourceDir.new(XML::DIR + '/src')
  #   srcdir.saved_dates
  #   
  #   resp = API.fetch({:laterthan => '2011-01-01', :num => 200})
  #   doc = XML::SourceDocument.parse resp.body
  # end
  
end

include Cityment