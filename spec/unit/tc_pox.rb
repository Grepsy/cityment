require 'minitest/autorun'
require 'cityment/xml/pox'

include Cityment::XML::POX

describe SourceDocument do
  
  describe :parse do
    it "automatically parses file when only path is given" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      assert_equal(doc.filename, '20110316-20110316.xml')
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
  describe :filename do
    it "returns a file name based on first and last item date" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      
      filename = '20110316-20110316.xml'
      
      assert_equal(doc.filename, filename)
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
  describe :save do
    it "saves files using a first and last datestamp" do
      fixture_path = FIXDIR + '/source_document.xml'      
      doc = SourceDocument.parse(File.read(fixture_path))

      save_dir = SourceDir.new('xml/testdir')
      save_path = DIR + '/testdir/20110316-20110316.xml'
      
      save_dir.save(doc)
      
      assert(File.read(fixture_path) == File.read(save_path))
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
  end
end