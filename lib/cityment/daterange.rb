require 'date'

module Cityment
  module EnumDateRange  
    def EnumDateRange.complete_range
      (Date.parse('2007-01-01')...Date.today).extend EnumDateRange
    end
  
    def each_year
      years = []
      if block_given?    
        grouped_dates = self.group_by {|date| date.year}
        grouped_dates.each_value do |dates|
          years << (yield (dates[0]..dates[-1]))
        end
      else
        return self.enum_for(:each_year)
      end
      years
    end

    def each_month
      months = []
      if block_given?
        self.each_year do |range|
          grouped_dates = range.group_by {|date| date.month}
          grouped_dates.each_value do |dates|
            months << (yield (dates[0]..dates[-1]))
          end
        end
      else
        return self.enum_for(:each_month)
      end
      months
    end
  
    def shorten last
      return self
    end  
  end
end