require 'yajl'
require 'rufus/verbs'

module Cityment
  
  class CouchDB
    attr_reader :encoder, :endpoint
    
    def initialize debug = false
      
      @endpoint = Rufus::Verbs::EndPoint.new(
                    :host => 'localhost',
                    :port => '5984',
                    :base => 'cityment')
      
      if debug == true
        @encoder = Yajl::Encoder.new :pretty => true
        @endpoint.opts[:dry_run] = true
      else
        @encoder = Yajl::Encoder.new
      end
    end
    
    def encode item_hash
      encoder.encode(item_hash) # {"title" => "...", "date" => "..."}
    end
    
    def uuid
      endpoint.get :base => '', :resource => '_uuid'
    end
    
    def print item_hash, file = 'spec/fixtures/item.json'
      item_json = encode(item_hash)
      File.open(file, 'w') do |f|
        f.puts item_json
      end
    end
    
    
    
  end
  
  DB = CouchDB.new
  
end