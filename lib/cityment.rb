require 'cityment/api'
require 'cityment/xml'
require 'cityment/datetime'
require 'cityment/daterange'
require 'cityment/couchdb'

module Cityment
  
  def Cityment.crawl
    
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
  
  def Cityment.insert
    
    inserted_dates = DB.saved_dates
    
    XML::SRCDIR.source_files.each do |file|      
      
      doc = XML::SourceDocument.parse(file)
      
      unless doc.date_range.max <= inserted_dates.max     
        puts "Starting to insert #{doc.date_range} into database"  
        
        doc.items.each do |item|         
          unless DateTime.from_json(item[:created_at]) <= inserted_dates.max
            resp = DB.create(item)
            if resp.code.to_i == 201
              puts "Inserted item created at #{item[:created_at]} into database"
            else
              puts "HTTP Response Code #{resp.code}"
              puts "Failed to insert item created at #{item[:created_at]} into database"
            end
          end              
        end # Each item
        
      else
        puts "Skipped already inserted file #{doc.date_range}"
      end
         
    end # Each file
    
    return inserted_dates.max..DB.saved_dates.max
    
  end
  
end # Cityment