require 'cityment/api'
require 'cityment/xml'
require 'cityment/xml/pox'
require 'cityment/datetime'

module Cityment
  
  def parse_response resp
    XML::POX::SourceDocument.parse resp.body
  end
  
  def crawl_range range = [DateTime.parse('2010-01-01'), DateTime.parse('2010-04-01')]
    
    save_dir = XML::POX::SourceDir.new "xml/src/#{range[0].stamp}-#{range[1].stamp}"
    
    crawler = Enumerator.new do |y|
      while range[1] > range[0]
        doc = parse_response(API.fetch_range(range[0], range[1]))
        break if range[1] == doc.dates[0]
        y << doc
        range[1] = doc.dates[0]
      end
    end
    
    crawler.each do |doc|
      save_dir.save(doc)
      puts "Saved #{doc.dates.count} items, between #{range[0]} and #{range[1]}"  
    end
    
    return save_dir
    
  end
  
end

include Cityment