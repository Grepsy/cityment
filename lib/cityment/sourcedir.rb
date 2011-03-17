require 'date'

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