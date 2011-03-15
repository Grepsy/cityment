require 'minitest/autorun'
require 'cityment/api'

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
      
    res = fetch :num => 10, :laterthen => '2009-01-01'
    assert(res.code.to_i == 200, "Incorrect respone code: #{res.code.to_i}")
  end
  
end