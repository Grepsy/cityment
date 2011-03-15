require 'rufus/verbs'

module Cityment
  module API
    ENDPOINT = Rufus::Verbs::EndPoint.new(      
      {host: 'api.at5.nl',
       port: 80,
       base: 'v1/news.xml',
       params: {token: 'appsadam_1'}})
       
    def fetch params = {}
      def_params = ENDPOINT.opts[:params]
      req_params = def_params.merge params
      
      ENDPOINT.get :params => req_params
    end    
  end
end #cityment