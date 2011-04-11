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
  # describe :saved_dates do
  #   it "lists date ranges of saved files" do
  #     srcdir = SourceDir.new 'xml/testdir'
  #     doc = SourceDocument.parse(FIXDIR + '/source_document.xml')
  #     srcdir.save(doc)
  #     
  #     fixdates = [DateTime.parse('20110316115112'), DateTime.parse('20110316185937')]
  #     assert(srcdir.saved_dates[0] == fixdates, "Unexpected saved dates: #{srcdir.saved_dates}")
  #   end
  # end
  
  after do
    FileUtils.rm_rf TSTDIR
  end
end