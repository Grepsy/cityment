require 'nokogiri'
require 'date'

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
  end # XML
end #Cityments

class DateTime
  def stamp
    self.to_date.iso8601.to_s.delete('-')
  end
end
