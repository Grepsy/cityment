require 'rufus/verbs'

module Cityment
  module API
    ENDPOINT = Rufus::Verbs::EndPoint.new(      
      {host: 'api.at5.nl',
       port: 80,
       base: 'v1/news.xml',
       params: {token: 'appsadam_1'}})
       
    def API.fetch params = {}, respClass = nil
      def_params = ENDPOINT.opts[:params]
      req_params = def_params.merge params
      
      resp = ENDPOINT.get :params => req_params
      resp = respClass.new(resp.body) unless respClass == nil
      return resp
    end
        
  end
end #cityment