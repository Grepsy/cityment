require 'yajl'

module Cityment
  
  class CouchDB
    attr_reader :encoder
    
    def initialize
      @encoder = Yajl::Encoder.new :pretty => true
    end
    
    def encode item_hash
      encoder.encode(item_hash) # {"title" => "...", "date" => "..."}
    end
    
    # def create item_hash
    #   item_json = encode(item_hash)
    #   File.open('spec/fixtures/item.json', 'w') do |f|
    #     f.puts item_json
    #   end
    # end
  end
  
  DB = CouchDB.new
  
end