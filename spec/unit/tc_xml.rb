require 'minitest/autorun'
require 'cityment/xml'
require 'fileutils'

include Cityment::XML

describe Document do
  
  describe :save do
    it "saves file to /xml folder" do    
      fixture_path = ENV['APP_ROOT'] + '/spec/fixtures/xmldoc.xml'
      save_path = ENV['APP_ROOT'] + '/xml/tmp_unit_test.xml'
      
      xmldoc = Document.parse(File.read(fixture_path))
      xmldoc.save 'tmp_unit_test.xml'
      
      assert(xmldoc.to_xml == File.read(save_path))
      FileUtils.rm(save_path)
    end
    it "returns an array of syntax errors instead of saving when present" do

      fixture_path = ENV['APP_ROOT'] + '/spec/fixtures/syntax_error.xml'      
      xmldoc = Document.parse(File.read(fixture_path))
      
      assert(xmldoc.save('test_syntax_error.xml').sample.kind_of? Nokogiri::XML::SyntaxError )
    end
  end
  
end

#describe SourceDoc do
#  
#  describe :date_range do
#    
#    it "returns an array containing the first and last item date" do
#      
#    srcdoc  
#    assert(srcdoc.date_range[1] < srcdoc.date_range[2])
#    
#  end
#  
#end 