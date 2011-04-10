require 'cityment/xml'

module Cityment
  module XML
    module POX
      
      class SourceDocument < XML::Document
        def dates
          @dates ||= self.xpath('/result/items/item/created_at').map do |e|
            DateTime.parse(e.inner_text)
          end.sort!
          #return []
        end

        def save
          File.exist?(DIR + '/src') || Dir.mkdir(DIR + '/src') 
          super 'src/' + dates[0].stamp + '-' + dates[-1].stamp + '.xml'
        end
      end
      
      class SourceDir < Dir
        attr_reader :pattern

        def initialize dir = 'xml/src', pattern =  "*-*.xml"
          super dir
          @pattern =  "*-*.xml"
        end

        def source_files
          self.class.glob(File.join(path, pattern))
        end

        def saved_dates
         source_files.map do |f|
            m = f.match(/(\d{8})-(\d{8})/)
            [Date.parse(m[1]), Date.parse(m[2])]
          end
        end
      end
      
    end # POX
  end # XML
end # Cityments

class DateTime
  def stamp
    self.to_date.iso8601.to_s.delete('-')
  end
end