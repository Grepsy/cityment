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
      
      @endpoint.parsers['application/json'] = Yajl::Parser
      
      if debug == true
        @encoder = Yajl::Encoder.new :pretty => true
        @endpoint.opts[:dry_run] = true
      else
        @encoder = Yajl::Encoder.new
      end
    end
    
    def encode body, head = {}
      head.merge! body
      encoder.encode(head) # {"title" => "...", "date" => "..."}
    end
    
    def uuid
      resp = endpoint.get :base => '', :resource => '_uuids'
      resp = resp[:uuids].to_s unless endpoint.opts[:dry_run] == true
      resp
    end
    
    def create item
      req = encode(item, {:_id => uuid})
      endpoint.post(:headers => {'content-type' => 'application/json'},  :data => req)
    end
    
    # def print item_hash, file = 'spec/fixtures/item.json'
    # 
    #   body = item_hash
    #   item_json = encode(body, head)
    #   File.open(file, 'w') do |f|
    #     f.puts item_json
    #   end
    # end    
  end # CouchDB
  
  DB = CouchDB.new
  
end