require 'rufus/verbs'
require 'cityment/config'
require 'cityment/datetime'

module Cityment
  module API
    
    ENDPOINT = Rufus::Verbs::EndPoint.new(Cityments::Config.load('endpoint'))
       
    def API.fetch params = {}
      def_params = ENDPOINT.opts[:params]
      req_params = def_params.merge params
      
      resp = ENDPOINT.get :params => req_params
    end
    
    def API.fetch_range startdt, enddt
      fetch :betweena => startdt.at5_api_format, :betweenb => enddt.at5_api_format
    end
        
  end
end #cityment