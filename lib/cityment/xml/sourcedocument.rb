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
      
    end
    
  end # XML
end # Cityment