require 'fileutils'
require 'minitest/autorun'
require 'cityment/xml/sourcedocument'

include Cityment::XML

FIXDIR = 'spec/fixtures'

describe SourceDocument do
  describe :parse do
    it "automatically parses file when only path is given" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      
      assert_equal(doc.filename, '20110316115112-20110316185937.xml')
    end
  end
  describe :dates do
    it "returns an array of item dates in source document" do  
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      
      assert(doc.dates.sample.kind_of? DateTime)
    end
    it "sorts dates chornologically" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      
      assert(doc.dates.first < doc.dates[-1])
    end
  end
  describe :date_range do
    it "returns a range of item dates in source document" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      first = DateTime.parse('2011-03-16 11:51:12')
      last = DateTime.parse('"2011-03-16 18:59:37')
      range = first..last  
    
      assert_equal(range, doc.date_range)
    end
  end
  describe :filename do
    it "returns a file name based on first and last item date" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      
      filename = '20110316115112-20110316185937.xml'
      
      assert_equal(doc.filename, filename)
    end
  end
  describe :item_to_hash do
    it 'it converts items to a hash' do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
          
      assert_equal(
        'http://www.at5.nl/uploads/media/2011/02/28/4cac455e97248.jpg',
         doc.item_to_hash[:images][:image][:url]
         )
    end
    it 'filters nokogiri text nodes' do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
          
      refute(doc.item_to_hash[:text])
    end
    it 'converts numeric fields to integers' do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      item = doc.xpath('/result/items/item[1]')
      
      assert_kind_of(Integer, doc.item_to_hash(item)[:images][:image][:height])
    end
    it 'converts DateTime fields' do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      item = doc.xpath('/result/items/item[1]')
      
      assert_kind_of(DateTime, doc.item_to_hash(item)[:created_at])
    end
  end
  describe :item do
    it 'returns a collection of items' do
       doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
       
       assert_equal(21, doc.items.count)
    end
  end
end
