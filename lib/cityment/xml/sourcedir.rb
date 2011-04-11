require 'fileutils'

module Cityment
  module XML
      ENV['DATADIR'] ||= 'data/cityment'
            
      class SourceDir < Dir              
        attr_reader :pattern
        
        def initialize root, pattern = "**/*-*.xml"
          File.exist?(root) || FileUtils.mkpath(root)
          super root
          @pattern = pattern
        end
        
        def save srcdoc
          save_date = srcdoc.date_range.first
          save_dir = self.path + '/' + save_date.year.to_s + '/' + save_date.month.to_s
          File.exist?(save_dir) || FileUtils.mkpath(save_dir)

          Dir.chdir(save_dir) do
            File.open(srcdoc.filename, 'w') do |f|
              f.puts srcdoc.to_xml
            end
          end
          
        end
        
        def source_files
          self.class.glob(File.join(path, pattern))
        end
        
        def saved_dates within = nil
         
         ranges = source_files.map do |f|
            m = f.match(/(\d{14})-(\d{14})/)
            DateTime.parse(m[1])..DateTime.parse(m[2])
          end
        
          if within.respond_to? :umbrella?
            ranges.select {|range| within.umbrella? range}
          else
            ranges
          end
          
        end
        
        def date_gaps within
          
          saved_dates = self.saved_dates(within)
          
          if saved_dates != nil
            return within
          else
            return within
          end
          
        end
      end
      
      SRCDIR = SourceDir.new ENV['DATADIR'] + '/src'
      
  end # XML
end # Cityments