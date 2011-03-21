require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BGCIdentityResolver do
  
  it "should be a singleton"
  
  describe "retrieve_id" do
    it "should return a hash of all available identifiers if no targets are specified" do
      BGCIdentityResolver.resolve_id("10000003").should == {"aat"=>"300140808", "vam"=>"145", "dbpedia"=>"Delftware", "groveDecArts"=>"e0989", "bm"=>"299", "lcsh"=>"sh85036571"}
    end
    it "should return single identifiers if only one target is specified" do
      BGCIdentityResolver.resolve_id("10000003", :aat).should == "300140808"
    end
    it "should return a hash of identifiers if an array of targets is specified" do
      BGCIdentityResolver.resolve_id("10000003", [:aat, :vam, :dbpedia, :groveDecArts]).should == {"aat"=>"300140808", "vam"=>"145", "dbpedia"=>"Delftware", "groveDecArts"=>"e0989"}
    end
    it "should return nil if no identifier is know for the requested target" do
      BGCIdentityResolver.resolve_id("10000003", :bhl).should be_nil
      BGCIdentityResolver.resolve_id("10000003", [:aat,:bhl]).should == {"aat"=>"300140808", "bhl"=>nil}
    end
    it "should raise UnknownIdentifier if a bad identifier is provided" do
      lambda { BGCIdentityResolver.resolve_id("blah1345", :aat) }.should raise_error(BGCIdentityResolver::UnknownIdentifierException, "Could not find authority info for blah1345")
    end
  end
  
end
