require 'yajl'
require 'cityment/datetime'
require 'cityment/daterange'
require 'rufus/verbs'

module Cityment
  
  class CouchDB
    attr_reader :encoder, :endpoint
    
    def initialize debug = false

      @endpoint = Rufus::Verbs::EndPoint.new(Cityment::Config.load('couchdb')) 
      @endpoint.parsers['application/json'] = Yajl::Parser
      
      # Create database if DB doesn't exist
      if endpoint.get.code.to_i == 404
        @endpoint.put
      end
      
      if endpoint.get(:id => '/_design/all/_view/by_date').code.to_i == 404
         view = File.read(File.join(ENV['APP_ROOT'], 'views', 'all.json'))
         @endpoint.post(:h => {'content-type' => 'application/json'}, :data => view)
      end
      
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
      resp = endpoint.get :base => '', :resource => '_uuids', :h => {'accept' => 'application/json'}
      resp = resp[:uuids].to_s unless endpoint.opts[:dry_run] == true
      resp
    end
    
    def create item
      req = encode(item, {:_id => uuid})
      endpoint.post(:h => {'content-type' => 'application/json'}, :data => req)
    end
    
    def saved_dates
      begin
        first = endpoint.get(:id => '/_design/all/_view/by_date?limit=1', :h => {'accept' => 'application/json'})
        first = first.body['rows'].first['key']
        first_dt = DateTime.from_json(first)
      
        last = endpoint.get(:id => '/_design/all/_view/by_date?limit=1&descending=true', :h => {'accept' => 'application/json'})
        last = last.body['rows'].last['key']
        last_dt = DateTime.from_json(last)
      
        range = (first_dt..last_dt).extend DateRange
        return range
      rescue
        range = Date.parse('2007-01-01')..Date.parse('2007-01-02')
        return range
      end
    end
  end # CouchDB
  
  DB = CouchDB.new
  
end