require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Auction do
  describe "#load_instance" do
    it "should assemble an Auction object" do
      SolrService.should_receive(:solr_response_for_doc_id).with("10000002").and_return(["solr response","solr document"])
      AATVocabularyService.should_receive.expects(:retrieve).with(:bgc_id=>"10000002").and_return("AAT response")
      BGCIdentityResolver.should_receive(:resolve).with("10000002", :christies).and_return("christies internal id")
      auction = Auction.load_instance("10000002")
      auction.aat.should == "AAT response"
      auction.solr_doc.should == "solr document"
      auction.solr_response.should == "solr response"
      auction.auction_house_id.should == "christies internal id"
      auction.auction_house.should == :christies
      auction.auction_house_sale_url.should == "this should be a christies url"
    end
  end
end
