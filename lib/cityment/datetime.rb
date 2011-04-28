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
    json_format = ["%Y","%m", "%d", "%H", "%M", "%S"]
    json_format.collect{|f| self.strftime(f).to_i}
  end
  def DateTime.from_json array
    json_format = ["%Y","%m", "%d", "%H", "%M", "%S"]
    self.strptime(array.join("-"), json_format.join("-"))    
  end
end

class String
  def to_datetime
    DateTime.parse(self)
  end
end