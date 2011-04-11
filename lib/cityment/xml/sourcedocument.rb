require 'fileutils'
require 'cityment/datetime'
require 'nokogiri'

module Cityment
  module XML
    
    ENV['DATADIR'] ||= 'data/cityment'
    SRCDIR = ENV['DATADIR'] + '/src'
    
    class SourceDocument < Nokogiri::XML::Document
      
      def SourceDocument.save srcdoc, srcdir = SRCDIR
        save_date = srcdoc.date_range.first
        save_dir = srcdir + '/' + save_date.year.to_s + '/' + save_date.month.to_s
        File.exist?(save_dir) || FileUtils.mkpath(save_dir)
       
        Dir.chdir(save_dir) do
          File.open(srcdoc.filename, 'w') do |f|
            f.puts srcdoc.to_xml
          end
        end
         
      end
      
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