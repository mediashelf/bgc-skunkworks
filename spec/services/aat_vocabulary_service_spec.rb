require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AATVocabularyService do

  it "should be kind of VocabularyService" do
    # @service.should be_kind_of VocabularyService
  end
  
  it "should be a singleton"
  
  describe "instance" do
    it "should be an AATVocabularyService" do
      AATVocabularyService.instance.should be_instance_of(AATVocabularyService)
    end
  end
  
  describe "retrieve" do
    it "should assume that strings are AAT ids" do
      aat_subject = AATVocabularyService.instance.retrieve("300140808")
      aat_subject.should be_instance_of(AATSubject)
    end
    it "should use BGCIdentityResolver if :bgc_id is provided" do
      BGCIdentityResolver.should_receive(:resolve).with("10000002", :aat).and_return("300140808")
      AATVocabularyService.instance.retrieve(:bgc_id=>"10000002")
    end
  end
  
  describe "get_subject_xml" do
    it "should retrieve subject xml from the AAT webservice" do
      pending "don't want to hit the getty services everytime we run tests..."
      expected = fixture("300140808.xml").read
      result = AATVocabularyService.instance.get_subject_xml("300140808")
      EquivalentXml.equivalent?(result, expected).should be_true
    end
  end
  
end
