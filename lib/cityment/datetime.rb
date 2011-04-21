require 'date'

class DateTime
  def at5_api_format
    format = "%Y-%m-%d %H:%M:%S"
    self.strftime(format)
  end
  def stamp
    format ="%Y%m%d%H%M%S"
    self.strftime(format)
  end
  def json    
    format = ["%Y","%m", "%d", "%H", "%M", "%S"]
    format.collect{|f| self.strftime(f).to_i}
  end
end

class String
  def to_datetime
    DateTime.parse(self)
  end
end