require 'minitest/autorun'
require 'cityment/xml/pox'

include Cityment::XML::POX

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
  describe :save do
    it "saves files using a first and last datestamp" do
      fixture_path = FIXDIR + '/source_document.xml'      
      doc = SourceDocument.parse(File.read(fixture_path))
      doc.save
      
      save_path = DIR + '/src/20110316-20110316.xml'
      
      assert(File.read(fixture_path) == File.read(save_path))
    end
  end
end

describe SourceDir do
  describe :intialize do
    it "creates the directory on disk" do
      srcdir = SourceDir.new('xml/testdir')
      assert(File.exist?('xml/testdir'))
    end
  end
  describe :source_files do
    it "lists the saved source files" do
      srcdir = SourceDir.new 'spec/fixtures/'
      assert(srcdir.source_files.include? "spec/fixtures/20110316-20110317.xml")
    end
  end
  describe :saved_dates do
    it "lists date ranges of saved files" do
      srcdir = SourceDir.new 'spec/fixtures/'
      fixdates = [Date.parse('20110316'), Date.parse('20110317')]
      assert(srcdir.saved_dates[0] == fixdates, "Unexpected saved dates: #{srcdir.saved_dates}")
    end
    #it "sorts by start of date range" do
    #  srcdir = SourceDir.new 'spec/fixtures/'
    #  
    #end
  end
end