require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AATSubject do
  # before(:each) do
  #   @entry = AATVocabularyService.instance.retrieve("300140808")
  # end
  
  it "should use OM" do
    AATSubject.included_modules.should include(OM::XML::Document)
  end
  
  it "should define the necessary terms" do
    desired_terms = [[:description_text], [:id], [:subject, :parent_relationships]]
    desired_terms.each do |pointer|
      AATSubject.terminology.should have_term(*pointer)
    end
  end
  
end
