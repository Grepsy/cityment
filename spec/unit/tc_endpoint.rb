require 'minitest/autorun'
require 'cityment/api'

include Cityment::API

describe 'API::ENDPOINT' do
  describe :get do
    it 'prepares a request to the webservice' do
      
      path_fixture = '/v1/news.xml?token=appsadam_1'
        
      req = ENDPOINT.get :dry_run => true
      assert(req.path == path_fixture)  
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