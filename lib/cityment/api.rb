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
    
    def API.fetch_range date_range
      
      startdt = date_range.min.to_datetime.at5_api_format
      enddt = date_range.max.to_datetime.at5_api_format
      
      fetch :betweena => startdt, :betweenb => enddt
      
    end
        
  end
end #cityment