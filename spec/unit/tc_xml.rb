require 'minitest/autorun'
require 'cityment/xml'
require 'fileutils'
require 'date'

include Cityment::XML

FIXDIR = ENV['APP_ROOT'] + '/spec/fixtures'

describe Document do
  
  describe :save do
    it "saves file to /xml folder" do    
      
      fixture_path = FIXDIR + '/xmldoc.xml'
      xmldoc = Document.parse(File.read(fixture_path))

      xmldoc.save 'test_xmldoc.xml'
      save_path = DIR + '/test_xmldoc.xml'
    
      assert(File.read(fixture_path) == File.read(save_path))
      FileUtils.rm(save_path)
    end
    
    it "returns an array of syntax errors (when present) instead of saving" do

      fixture_path = FIXDIR + '/syntax_error.xml'      
      xmldoc = Document.parse(File.read(fixture_path))
      
      assert(xmldoc.save('test_syntax_error.xml').sample.kind_of? Nokogiri::XML::SyntaxError )
    end
  end
  
end

describe SourceDocument do
  
  describe :dates do
    
    it "returns an array of item dates in source document" do  
      fixture_path = FIXDIR + '/source_document.xml'
      doc = SourceDocument.parse(File.read(fixture_path))
      
      assert(doc.dates.sample.kind_of? DateTime)
    end
    it "sorts dates chornologically" do
      fixture_path = FIXDIR + '/source_document.xml'
      doc = SourceDocument.parse(File.read(fixture_path))
      
      assert(doc.dates.first < doc.dates[-1])
    end
  end
end 