require 'date'

class DateTime
  def at5_api_format
    format = "%Y-%m-%d %H:%M:%S"
    self.strftime(format)
  end
  def stamp
    format ="%Y%m%d"
    self.strftime(format)
  end
end

class String
  def to_datetime
    DateTime.parse(self)
  end
end