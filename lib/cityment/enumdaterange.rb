require 'date'

module Cityment
  module EnumDateRange

    def each_year
      if block_given?    
        grouped_dates = self.group_by {|date| date.year}

        grouped_dates.each_value do |dates|
          yield (dates[0]..dates[-1])
        end
      else
        self.enum_for(:each_year)
      end
    end

    # def each_month
    #   if block_given?
    #     self.each_year do |range|
    #       grouped_dates = range.group_by {|date| date.month}
    # 
    #       grouped_dates.each_value do |dates|
    #         yield (dates[0]..dates[-1])
    #       end
    #     end
    #   else
    #     self.enum_for(:each_month)
    #   end
    # end
    
  end
end