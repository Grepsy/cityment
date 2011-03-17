require 'yajl'

module Cityments
  module Config
  
    CFGPATH = ENV['APP_ROOT'] + '/config'
    PARSER = Yajl::Parser.new :symbolize_keys => true
  
    def Config.load cfgname
      file = File.read("#{CFGPATH}/#{cfgname}.json")
      PARSER.parse(file)
    end
    
  end # Config
end # Cityments
