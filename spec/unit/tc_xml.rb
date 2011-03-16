require 'minitest/autorun'
require 'cityment/xml'
require 'fileutils'

include Cityment::XML

describe Document do
  
  FIXDIR = ENV['APP_ROOT'] + '/spec/fixtures'
  
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