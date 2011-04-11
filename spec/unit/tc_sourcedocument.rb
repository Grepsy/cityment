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
end
