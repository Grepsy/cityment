require 'nokogiri'

module Cityment
  module XML
    
    DIR = ENV['APP_ROOT'] + '/xml'
    File.exist?(DIR) || Dir.mkdir(DIR) 
    
    class Document < Nokogiri::XML::Document
      
      def save filename
        return errors unless errors == []
        Dir.chdir(DIR) do
          File.open(filename, 'w') do |f|
            f.puts self.to_xml
          end
        end      
      end
      
    end #Document
    
    class SourceDocument < Document
      
      def dates
        @dates ||= self.xpath('/result/items/item/created_at').map do |e|
          DateTime.parse(e.inner_text)
        end.sort!
        #return []
      end
      
    end
    
  end # XML
end #Cityments