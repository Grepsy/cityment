require 'rufus/verbs'
require 'cityment/config'
require 'cityment/datetime'
require 'nokogiri'

module Cityment
  module API
    
    ENDPOINT = Rufus::Verbs::EndPoint.new(Cityments::Config.load('endpoint'))
    
    PARSERS = {'application/xhtml+xml; charset=utf-8' => Nokogiri::XML::Document}
       
    def API.fetch params = {}
      def_params = ENDPOINT.opts[:params]
      req_params = def_params.merge params
      
      resp = ENDPOINT.get :params => req_params
      resp = parse_body(resp) unless resp.class == Net::HTTP::Get
      resp
    end
    
    def API.parse_body response
      content_type = response.header['content-type']
      
      if content_parser = PARSERS[content_type]
        response.body = content_parser.send(:parse, response.body)
      end
      
      response
    end
    
    def API.fetch_range date_range
      
      startdt = date_range.min.to_datetime.at5_api_format
      enddt = date_range.max.to_datetime.at5_api_format
      
      fetch :betweena => startdt, :betweenb => enddt
      
    end
        
  end
end #cityment