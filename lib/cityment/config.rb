require 'yajl'

module Cityment
  module Config
  
    CFGPATH = ENV['APP_ROOT'] + '/config'
    PARSER = Yajl::Parser.new :symbolize_keys => true
  
    def Config.load cfgname
      json = File.read("#{CFGPATH}/#{cfgname}.json")
      cfg = PARSER.parse(json)
    end
    
  end # Config
end # Cityments
