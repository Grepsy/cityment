require 'minitest/autorun'
require 'cityment/couchdb'
require 'cityment/xml/sourcedocument'

include Cityment

describe CouchDB do
  describe :initialize do
    it 'sets Yajl as the encoder' do
      db = CouchDB.new
      assert_kind_of(Yajl::Encoder, db.encoder)
    end
  end
  describe :encode do
    it 'encodes item to a json string' do
       doc = XML::SourceDocument.parse('spec/fixtures/source_document.xml')
       item = doc.items[0]
       db = CouchDB.new
       
       #db.create(item)
       
       assert(db.encode(item).kind_of? String)
     end
  end
end