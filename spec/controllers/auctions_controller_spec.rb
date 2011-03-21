require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AuctionsController do

  it "should be kind of ActionController" do
    controller.should be_kind_of ActionController
  end
  
  describe "show" do
    before(:each) do
      get :show, :id=>"auction:113"
    end

    it "should load auction object" do
      assigns["auction"].should be_instance_of Auction
    end

    it "should load lots array (images from this sale)" do
      pending "Possibly this search should be performed against an AuctionLotsController in an iframe?"
      assigns["lots"].each do {|lot| lot.should be_instance_of AuctionLot}
    end
  end
  

end
