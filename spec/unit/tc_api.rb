require 'minitest/autorun'
require 'cityment/api'
require 'cityment/xml/sourcedocument'
require 'tempfile'
require 'cityment/datetime'

include Cityment::API

ENDPOINT.opts[:dry_run] = true

describe ENDPOINT do
  describe :get do
    it 'prepares a request to the webservice' do
      
      path_fixture = '/v1/news.xml?token=appsadam_1'
        
      req = ENDPOINT.get
      assert_equal(req.path, path_fixture)
    end
  end
end

describe :fetch do
  it 'executes a request inculding extra parameters' do
    path_fixture = '/v1/news.xml?token=appsadam_1&num=200'        
    
    req = API.fetch :num => 200
    
    assert_equal(req.path, path_fixture)
  end
end

describe :fetch_range do
  it "fetches a response within a DateTime range" do
    
    start_date = DateTime.parse '2009-01-01 00:00:00'
    end_date = DateTime.parse '2010-01-01 00:00:00'
    date_range = start_date..end_date
    
    req = API.fetch_range(date_range)
    path_fixture = '/v1/news.xml?token=appsadam_1&betweena=2009-01-01+00%3A00%3A00&betweenb=2010-01-01+00%3A00%3A00'
     
    assert_equal(req.path, path_fixture)
  end
  it "fetches a response within a Date range" do
    
    start_date = Date.parse '2009-01-01'
    end_date = Date.parse '2010-01-01'
    date_range = start_date..end_date
    
    req = API.fetch_range(date_range)
    path_fixture = '/v1/news.xml?token=appsadam_1&betweena=2009-01-01+00%3A00%3A00&betweenb=2010-01-01+00%3A00%3A00'
     
    assert_equal(req.path, path_fixture)
  end
    
end
