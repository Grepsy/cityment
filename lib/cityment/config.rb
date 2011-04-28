require 'yaml'
require 'rake'

module Cityment
  module Config
    
    cfg_files = FileList[File.join(ENV['CFGPATH'], '*.yaml')]
    CONFIG = {}

    cfg_files.each do |file|
      cfg_name = File.basename(file, '.yaml').to_sym
      cfg = YAML.load(File.read(file))
      CONFIG[cfg_name] = cfg
    end
      
    def Config.load cfg_name
      CONFIG[cfg_name.to_sym]
    end
    
  end # Config
end # Cityments
