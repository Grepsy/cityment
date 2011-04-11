module Cityment
  module XML
    
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
        
        def delete
          p FileUtils.rm_rf(self.path)
        end
      end
      
  end # XML
end # Cityments