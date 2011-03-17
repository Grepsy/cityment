require 'rufus/verbs'
require 'cityment/config'

module Cityment
  module API
    
    ENDPOINT = Rufus::Verbs::EndPoint.new(Cityments::Config.load('endpoint'))
       
    def API.fetch params = {}
      def_params = ENDPOINT.opts[:params]
      req_params = def_params.merge params
      
      resp = ENDPOINT.get :params => req_params
      
    end
        
  end
end #cityment