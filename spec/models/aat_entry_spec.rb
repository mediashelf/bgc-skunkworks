require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AATEntry do
  # before(:each) do
  #   @entry = AATVocabularyService.instance.retrieve("300140808")
  # end
  
  it "should us OM" do
    AATSubject.included_modules.should include(OM::Document)
    AATSubject.terminology.should == AATEntryTerminology
  end
  
end
