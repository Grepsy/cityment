require 'minitest/autorun'
require 'cityment/enumdaterange'

include Cityment

describe EnumDateRange do
  describe :each_year do
    it "it yields sub-ranges by year" do
      first = Date.parse('2009-01-01')
      last = Date.parse('2011-01-01')
      complete_range = first...last
      
      complete_range.extend EnumDateRange
      sub_ranges = complete_range.each_year.to_a
      
      assert_equal(sub_ranges[0].max, Date.parse('2009-12-31'))
      assert_equal(sub_ranges[1].min, Date.parse('2010-01-01'))
    end
  end
  describe :each_month do
    it "yields sub-ranges by month" do
      first = Date.parse('2009-01-01')
      last = Date.parse('2011-01-01')
      complete_range = first...last
      
      complete_range.extend EnumDateRange
      sub_ranges = complete_range.each_month.to_a
      
      assert_equal(sub_ranges.count, 24)
    end
  end
end
