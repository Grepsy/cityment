require 'minitest/autorun'
require 'cityment/xml/pox'

include Cityment::XML::POX

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
  describe :filename do
    it "returns a file name based on first and last item date" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      
      filename = '20110316115112-20110316185937.xml'
      
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
      fixture_path = (FIXDIR + '/source_document.xml')
      doc = SourceDocument.parse(fixture_path)

      save_dir = SourceDir.new('xml/testdir')
      save_path = 'xml/testdir/20110316115112-20110316185937.xml'
      
      save_dir.save(doc)
      
      assert(File.read(fixture_path) == File.read(save_path))
    end    
  end
  describe :source_files do
    it "lists the saved source files" do
      srcdir = SourceDir.new 'xml/testdir'
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      srcdir.save(doc)
      
      assert(srcdir.source_files.include? 'xml/testdir/20110316115112-20110316185937.xml')
    end
  end
  describe :saved_dates do
    it "lists date ranges of saved files" do
      srcdir = SourceDir.new 'xml/testdir'
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      srcdir.save(doc)
      
      fixdates = [DateTime.parse('20110316115112'), DateTime.parse('20110316185937')]
      assert(srcdir.saved_dates[0] == fixdates, "Unexpected saved dates: #{srcdir.saved_dates}")
    end
  end
end