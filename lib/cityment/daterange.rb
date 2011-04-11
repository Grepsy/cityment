require 'date'

module Cityment
  module DateRange  
    def DateRange.complete_range start_date = Date.parse('2007-01-01')
      (start_date...Date.today).extend DateRange
    end

    def crawl
      request_range = self
      
      while request_range.last > self.first
        fetched_range = yield request_range
        request_range = self.first...fetched_range.first
      end
      
      self
    end

    def each_year
      years = []
      if block_given?    
        grouped_dates = self.group_by {|date| date.year}
        grouped_dates.each_value do |dates|
          years << (yield (dates[0]..dates[-1]).extend DateRange)
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
            months << (yield (dates[0]..dates[-1]).extend DateRange)
          end
        end
      else
        return self.enum_for(:each_month)
      end
      months
    end
    
  end
end