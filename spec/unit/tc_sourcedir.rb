require 'minitest/autorun'
require 'cityment/xml/sourcedocument'
require 'cityment/xml/sourcedir'

include Cityment::XML

FIXDIR = 'spec/fixtures'
TSTDIR = SourceDir.new(ENV['DATADIR'] + '/tstsrc')

describe SourceDir do

  describe :save do
    it "creates a year/month folder containing the file" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      TSTDIR.save(doc)
      
      path = ENV['DATADIR'] + '/tstsrc/2011/3/20110316115112-20110316185937.xml'
      assert(File.exist?(path), "File #{path} doesn't exist")
    end
  end

  describe :source_files do
   it "lists the saved source files" do
     doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
     TSTDIR.save(doc)
   
     assert(TSTDIR.source_files.count <= 1, "#{TSTDIR.source_files.count} files found")
   end
  end
  
  describe :saved_dates do
    it "lists date ranges of saved files" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      TSTDIR.save(doc)
    
      fix_range = DateTime.parse('20110316115112')..DateTime.parse('20110316185937')
      assert(TSTDIR.saved_dates.include? fix_range)
    end
    it "filters ranges according 'within_range' argument" do
      doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
      TSTDIR.save(doc)
      
      fix_range = DateTime.parse('20110316115112')..DateTime.parse('20110316185937')
      within_range = Date.parse('2010-01-01')...Date.parse('2010-04-01')
      
      refute(TSTDIR.saved_dates(within_range).include? fix_range)
    end
  end
  
  after do
    FileUtils.rm_rf TSTDIR
  end
end