require 'minitest/autorun'
require 'cityment/api'

include Cityment::API

describe 'API::ENDPOINT' do
  describe :get do
    it 'prepare a request to the webservice' do
      
      path_fixture = '/v1/news.xml?token=appsadam_1'
        
      req = ENDPOINT.get :dry_run => true
      assert(req.path == path_fixture)  
    end
    
  end
end