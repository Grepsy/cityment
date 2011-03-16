require 'nokogiri'

module Cityments
  module XML
    
    DIR = ENV['APP_ROOT'] + '/xml'
    File.exist?(DIR) || Dir.mkdir(DIR) 
    
    class Document < Nokogiri::XML::Document
      
      def save filename       
        Dir.chdir(DIR) do
          File.open(filename, 'w') do |f|
            f.puts self.to_xml
          end
        end      
      end
      
    end #Document
    
  end # XML
end #Cityments