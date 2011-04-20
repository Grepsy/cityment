require 'cityment/api'
require 'cityment/xml'
require 'cityment/datetime'
require 'cityment/daterange'

module Cityment
  
  def crawl
    
    last_saved_date = Date.parse('2007-01-01')
    
    if XML::SRCDIR.saved_dates.last != nil
      saved_dates = XML::SRCDIR.saved_dates.sort_by {|range| range.min }
      last_saved_date = saved_dates.last.max
    end
    
    dates = DateRange.complete_range last_saved_date
    months = dates.each_month
    
    months.each do |month|
      puts "Starting to crawl #{month}"
      
      month.crawl do |request_range|
        doc = API.fetch_range(request_range).body
        puts "Fetched #{doc.dates.count} items, within range: #{request_range}"
        break if doc.dates.count == 0
        XML::SRCDIR.save(doc)
        fetched_range = doc.date_range
      end
      
    end
    
  end
  
  def process
    
    # class CouchDB
    #   def create
    #     return 'uuid'
    #   end
    # end
    # 
    # db = CouchDB.new
    
    XML::SRCDIR.source_files.each do |file|
      
      doc = XML::SourceDocument.parse(file)
      
      doc.items.each do |doc|
        database.create doc
      end 
           
    end
    
  end
  
end

include Cityment