require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AATVocabularyService do
  before(:each) do
    @service = AATVocabularyService.new
  end
  it "should be kind of VocabularyService" do
    @service.should be_kind_of VocabularyService
  end
  
  it "should be a singleton"
  
  describe "instance" do
    @service.instance.should be_kind_of AATVocabularyConnection
  end
  
  describe "retrieve" do
    it "should assume that strings are AAT ids" do
      aat_entry = AATVocabularyService.instance.retrieve("300140808")
      aat_entry.should be_kind_of AATEntry
    end
    it "should use BGCIdentityResolver if :bgc_id is provided" do
      BGCIdentityResolver.expects(:resolve).with("10000002", :aat).returns("300140808")
      AATVocabularyService.instance.retrieve(:bgc_id=>"10000002")
    end
    
    
  end
  
end
