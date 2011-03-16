require 'minitest/autorun'
require 'cityment/xml'
require 'fileutils'

include Cityments::XML

describe Document do
  
  describe :save do
    
    it "saves file to /xml folder" do
      
      fixture_path = ENV['APP_ROOT'] + '/spec/fixtures/xmldoc.xml'
      save_path = ENV['APP_ROOT'] + '/xml/tmp_unit_test.xml'
      
      xmldoc = Document.new(File.read(fixture_path))
      xmldoc.save 'tmp_unit_test.xml'
      
      assert(xmldoc.to_xml == File.read(save_path))
      FileUtils.rm(save_path)
    end
    
  end
end