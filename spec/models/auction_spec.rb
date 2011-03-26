require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Auction do
  describe "#load_instance" do
    it "should assemble an Auction object" do      
      # Couldn't figure out a way to stub the get_solr_response_for_doc_id method, so had to mock out the methods that it calls...
      # Auction.any_instance.should_receive(:get_solr_response_for_doc_id).with("10000002", {}).and_return(["solr response","solr document"])
      mock_solr_response = mock("solr response", :docs=>["solr document"])
      Blacklight.solr.should_receive(:find).and_return(mock_solr_response)
      SolrDocument.should_receive(:new).with("solr document", mock_solr_response).and_return("instantiated solr document")
      
      AATVocabularyService.should_receive(:retrieve_subject).with(:bgc_id=>"10000002").and_return("AAT response")
      BGCIdentityResolver.should_receive(:resolve_id).with("10000002", :christies).and_return("christies internal id")
      auction = Auction.load_instance("10000002")
      auction.aat.should == "AAT response"
      auction.solr_doc.should == "instantiated solr document"
      auction.solr_response.should == mock_solr_response
      auction.auction_house_id.should == "christies internal id"
      auction.auction_house.should == :christies
      auction.auction_house_sale_url.should == "this should be a christies url"
    end
  end
end
