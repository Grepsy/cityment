require 'minitest/autorun'
require 'cityment/sourcedir'

describe SourceDir do
  describe :source_files do
    it "lists the saved source files" do
      srcdir = SourceDir.new 'spec/fixtures/'
      assert(srcdir.source_files.include? "spec/fixtures/20110316-20110317.xml")
    end
  end
  #describe :saved_dates do
  #    srcdir = SourceDir.new
  #    fixdates = [Date.parse('20110316'), Date.parse('20110317')]
  #    assert(srcdir.saved_dates == fixdates)
  #end
end