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
  
  # def crawl_range range = [DateTime.parse('2010-01-01'), DateTime.parse('2010-04-01')]
  #   
  #   save_dir = XML::POX::SourceDir.new "xml/src/#{range[0].stamp}-#{range[1].stamp}"
  #   
  #   crawler = Enumerator.new do |y|
  #     while range[1] > range[0]
  #       doc = parse_response(API.fetch_range(range[0], range[1]))
  #       break if range[1] == doc.dates[0]
  #       y << doc
  #       range[1] = doc.dates[0]
  #     end
  #   end
  #   
  #   crawler.each do |doc|
  #     save_dir.save(doc)
  #     puts "Saved #{doc.dates.count} items, between #{range[0]} and #{range[1]}"  
  #   end
  #   
  #   return save_dir
  #   
  # end
  
end

include Cityment