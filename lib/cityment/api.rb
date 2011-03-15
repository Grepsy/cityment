require 'rufus/verbs'

module Cityment
  module API
    ENDPOINT = Rufus::Verbs::EndPoint.new(      
      {host: 'api.at5.nl',
       port: 80,
       base: 'v1/news.xml',
       params: {token: 'appsadam_1'}})
    
  end
end #cityment