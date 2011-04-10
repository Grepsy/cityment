require 'minitest/autorun'
require 'cityment/daterange'

include Cityment

describe DateRange do
  describe :complete_range do
    it 'returns a range between 2007-01-01 and today' do
      range = DateRange.complete_range
      assert_equal(range.min, Date.parse('2007-01-01'))
    end
    it 'extends the range with DateRange module' do
      range = DateRange.complete_range
      assert(range.respond_to? :each_month)
    end
  end
  describe :each_year do
    it "it yields sub-ranges by year" do
      first = Date.parse('2009-01-01')
      last = Date.parse('2011-01-01')
      complete_range = first...last
      
      complete_range.extend DateRange
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
      
      complete_range.extend DateRange
      sub_ranges = complete_range.each_month.to_a
      
      assert_equal(sub_ranges.count, 24)
    end
  end
  # describe :shorten do
  #   it "sets the last date in range" do
  #     first = Date.parse('2009-01-01')
  #     last = Date.parse('2011-01-01')
  #     complete_range = first...last
  #   
  #     complete_range.extend DateRange
  #     complete_range = 
  #   end
  # end
end
