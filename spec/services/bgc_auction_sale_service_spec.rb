require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "bgc_services/bgc_auction_sale_service"

describe BGCAuctionSaleService do
  
  it "should be a singleton"
  
  describe "retrieve" do
    it "should retrieve sale info" do
      result = BGCAuctionSaleService.retrieve("ocn181946344")
      result.should be_kind_of(Hash)
      result["saleURL"].should == "http://www.christies.com/LotFinder/print_sale.aspx?saleid=21410"
      result["intSaleID"].should == "21410"
    end
    it "should raise UnknownIdentifier if a bad identifier is provided" do
      lambda { BGCAuctionSaleService.retrieve("blah1345") }.should raise_error(BGCService::UnknownIdentifierException, "Could not find sale info for blah1345")
    end
  end
  
end
