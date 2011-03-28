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
    
    def API.fetch_range startdt, enddt
      dt_format = "%Y-%m-%d %H:%M:%S"
      fetch :betweena => startdt.strftime(dt_format), :betweenb => enddt.strftime(dt_format)
    end
        
  end
end #cityment