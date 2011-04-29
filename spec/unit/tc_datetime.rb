require 'minitest/autorun'
require 'cityment/datetime'

describe DateTime do
  describe :api_format do
    it "formats a string expected by AT5 API" do
      dt = DateTime.parse("2009-01-01T13:00:00+00:00")
      assert_equal(dt.at5_api_format, "2009-01-01 13:00:00")
    end
  end
  describe :stamp do
    it "returns a date stamp" do
      dt = DateTime.parse("2009-01-01T13:00:00+00:00")
      assert_equal(dt.stamp, '20090101130000')
    end
  end
  describe :json do
    it "transforms datetime in a json friendly format" do
      dt = DateTime.parse("2009-05-01T13:11:22+00:00")
      assert_equal([2009, 5, 1, 13, 11, 22], dt.json)
    end
  end
  describe :from_json do
    it "transforms json to a datetime object" do
      dt = DateTime.parse("2009-05-01T13:11:22+00:00")
      json = [2009, 5, 1, 13, 11, 22]
      assert_equal(dt, DateTime.from_json(json))
    end
  end
end

describe String do
  describe :to_datetime do
    it "parses the string to a DateTime object" do
     str = '2009-01-01'
     assert(str.to_datetime.kind_of? DateTime) 
    end
  end
end