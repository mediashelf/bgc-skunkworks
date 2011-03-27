require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "bgc_services/bgc_auction_lot_service"

describe BGCAuctionLotService do
    
  describe "retrieve" do
    it "should retrieve sale info" do
      result = BGCAuctionLotService.retrieve("21410")
      result.should be_kind_of(Array)
      result.each do |row|
        row.should be_kind_of Hash
        row["value"].should have_key "lotNumber"
        row["value"].should have_key "description"
        row["value"].should have_key "lotURL"
        row["value"].should have_key "thumbnail"
      end
    end
    it "should raise UnknownIdentifier if a bad identifier is provided" do
      lambda { BGCAuctionLotService.retrieve("blah1345") }.should raise_error(BGCService::UnknownIdentifierException, "Could not find lots corresponding to saleID: blah1345")
    end
  end
  
end
