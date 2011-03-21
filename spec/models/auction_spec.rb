require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Auction do
  describe "#load_instance" do
    it "should assemble an Auction object"
      SolrService.expects(:solr_response_for_doc_id).with("10000002").returns(["solr response","solr document"])
      AATVocabularyService.instance.expects(:retrieve).with(:bgc_id=>"10000002").returns("AAT response")
      BGCIdentityResolver.expects(:resolve).with("10000002", :christies).returns("christies internal id")
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
