require 'minitest/autorun'
require 'cityment/couchdb'
require 'cityment/xml/sourcedocument'

include Cityment

describe CouchDB do
  describe :initialize do
    it 'sets Yajl as the encoder' do
      db = CouchDB.new true
      assert_kind_of(Yajl::Encoder, db.encoder)
    end
  end
  describe :encode do
    it 'encodes item to a json string' do
       doc = XML::SourceDocument.parse('spec/fixtures/source_document.xml')
       item = doc.items[0]
       db = CouchDB.new true
       
       assert(db.encode(item).kind_of? String)
     end
  end
  describe :uuid do
    it 'fetches a new uuid from the server' do
      db = CouchDB.new true
      req = db.uuid
      
      assert_equal '/_uuid', req.path
    end
  end
end