require 'cityment/xml'
require 'cityment/datetime'

module Cityment
  module XML
    module POX
      
      class SourceDocument < XML::Document
        
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
        
        def filename
          dates[0].stamp + '-' + dates[-1].stamp + '.xml'
        end
      end
      
      class SourceDir < Dir
        attr_reader :pattern

        def initialize dir = 'xml/src', pattern = "*-*"
          File.exist?(dir) || Dir.mkdir(dir) 
          super dir
          @pattern =  pattern
        end
        
        def save srcdoc
          Dir.chdir(self.path) do
            File.open(srcdoc.filename, 'w') do |f|
              f.puts srcdoc.to_xml
            end
          end
        end
        
        def source_files
          self.class.glob(File.join(path, pattern))
        end

        def saved_dates
         source_files.map do |f|
            m = f.match(/(\d{14})-(\d{14})/)
            [DateTime.parse(m[1]), DateTime.parse(m[2])]
          end
        end
      end
      
    end # POX
  end # XML
end # Cityments