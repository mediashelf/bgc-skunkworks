require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Auction do
  
  before(:each) do
    @auction = Auction.new("ocn181946344")
    @sample_auction_json = JSON.parse('{"_id":"30002111","_rev":"1-5dcbd9dc47315084808298e9c805f2c0","saleNumber":"5323","scipioSaleCode":"POR 5323","scipioControlNumber":"ocn181946344","saleURL":"http://www.christies.com/LotFinder/print_sale.aspx?saleid=21410","intSaleID":"21410","briefTitle":"5323: BRITISH CERAMICS & GLASS 1630 -... (14 November 2007)"}')
  end
  
  
  describe '#new' do
    it "should set catalog_id" do
      @auction.catalog_id.should == "ocn181946344"
    end
  end
  
  it "should assemble an Auction object" do      
    pending
    # AATVocabularyService.should_receive(:retrieve_subject).with(:bgc_id=>"10000002").and_return("AAT response")
    # BGCIdentityResolver.should_receive(:resolve_id).with("10000002", :christies).and_return("christies internal id")
    # auction = Auction.load_instance("10000002")
    # auction.aat.should == "AAT response"

  end
  
  describe "#load_instance" do
    it "should load catalog and sale info into the auction object" do
      mock_auction = mock("auction")
      Auction.should_receive(:new).with("ocn181946344").and_return(mock_auction)
      mock_auction.should_receive(:load_sale_info)
      mock_auction.should_receive(:load_catalog_info)
      Auction.load_instance("ocn181946344")
    end
  end
  
  describe "load_sale_info" do
    it "should load auction info from the auctions service by solr id (ocn)" do
      BGCAuctionSaleService.should_receive(:retrieve).with("ocn181946344").and_return(@sample_auction_json)
      @auction.load_sale_info
      @auction.auction_house_sale_id.should == "21410"
      @auction.sale_number.should == "5323"
      @auction.auction_house_sale_url.should == "http://www.christies.com/LotFinder/print_sale.aspx?saleid=21410"
    end
  end
  
  describe "load_catalog_info" do
    it "should run a search against solr based on solr id" do
      @auction.should_receive(:get_solr_response_for_doc_id).with("ocn181946344", {}).and_return(["solr response","solr document"])
      @auction.load_catalog_info
      @auction.catalog_solr_doc.should == "solr document"
      @auction.catalog_solr_response.should == "solr response"
    end
  end
  
end
