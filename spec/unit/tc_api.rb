require 'minitest/autorun'
require 'cityment/api'
require 'cityment/xml/pox'
require 'tempfile'
require 'cityment/datetime'

include Cityment::API

describe ENDPOINT do
  describe :get do
    it 'prepares a request to the webservice' do
      
      path_fixture = '/v1/news.xml?token=appsadam_1'
        
      req = ENDPOINT.get :dry_run => true
      assert(req.path == path_fixture, "Incorrect request path: #{req.path}")  
    end
    
    it 'prepares a request including an extra paramater' do

      path_fixture = '/v1/news.xml?token=appsadam_1&num=200'
      
      def_params = ENDPOINT.opts[:params]
      req_params = def_params.merge :num => 200
          
      req = ENDPOINT.get :dry_run => true, :params => req_params
      assert(req.path == path_fixture, "Incorrect request path: #{req.path}")
    end
  end
end

describe :fetch do
  it 'executes a request inculding extra parameters' do
      
    res = Cityment::API.fetch :num => 10, :laterthen => '2009-01-01'
    assert(res.code.to_i == 200, "Incorrect respone code: #{res.code.to_i}")
  end
end

describe :fetch_range do
  it "executes a request between two dates" do
    start_date = DateTime.parse "2009-01-01 00:00:00"
    end_date = DateTime.parse "2009-02-01 00:00:00"
    
    resp = Cityment::API.fetch_range(start_date, end_date) 
    doc = Cityment::XML::POX::SourceDocument.parse(resp.body)
    assert(doc.dates.sample > start_date && doc.dates.sample < end_date)
  end
  it "takes accepts strings as date arguments" do
    start_date = '2009-01-01'
    end_date = '2009-01-02'
    
    resp = Cityment::API.fetch_range(start_date, end_date)
    doc = Cityment::XML::POX::SourceDocument.parse(resp.body)
    assert(doc.dates.sample > DateTime.parse(start_date) && doc.dates.sample < DateTime.parse(end_date))
  end
end
