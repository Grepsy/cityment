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
        
        field_type = {}
        field_type[:Integer] = [:height, :width]
        field_type[:DateTime] = [:created_at]

        
        item_hsh = item_src.children.inject({}) do |result, element|
          if element.children.count <= 1
            
            name = element.name.to_sym
            
            content = case 
            when field_type[:Integer].include?(name)
              element.inner_text.to_i
            when field_type[:DateTime].include?(name)
              dt = DateTime.parse(element.inner_text)
              dt.json
            else
              element.inner_text 
            end
            
            if name == :text
              result
            else
              result[name] = content
            end
            
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