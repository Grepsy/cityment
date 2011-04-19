require 'fileutils'
require 'cityment/datetime'
require 'nokogiri'

module Cityment
  module XML
      
    class SourceDocument < Nokogiri::XML::Document
            
      def SourceDocument.parse string_or_io
        if FileTest.file?(string_or_io)
          string_or_io = File.read(string_or_io)
        end
        super string_or_io
      end
    
      def dates
        @dates ||= self.xpath('/result/items/item/created_at').map do |e|
          DateTime.parse(e.inner_text)
        end.sort!
        #return []
      end
  
      def date_range
        self.dates[0]..self.dates[-1]
      end
  
      def filename
        dates[0].stamp + '-' + dates[-1].stamp + '.xml'
      end
      
      def items
        
        @items ||= self.xpath('/result/items/item').inject([]) do |result, item|
          result << item_to_hash(item)
          result
        end
        
        @items # [{:title => '...'}, {:title => '...'}]
        
      end
      
      def item_to_hash item_src = self.xpath('/result/items/item[1]')
        
        item_hsh = item_src.children.inject({}) do |result, element|
          if element.children.count <= 1
            result[element.name.to_sym] = element.inner_text 
          else
            result[element.name.to_sym] = item_to_hash(element)
          end
          result  
        end
        
        item_hsh #[:title => '...', :date => '...']
        
      end
      
    end
    
  end # XML
end # Cityment