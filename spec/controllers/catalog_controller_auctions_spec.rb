require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CatalogController do

  it "should include routes for auctions" do
    # route_for(:controller=>'auctions', :action=>'index').should == '/auctions'
    # route_for(:controller=>'auctions', :action=>'show', :id=>"test:3").should == '/auctions/test:3'
      
    params_from(:get, '/auctions').should == {:controller=>'catalog', :action=>'index'}
    params_from(:get, '/auctions/test:3').should == {:controller=>'catalog', :id=>"test:3", :action=>'show'}

    auction_path("test:3").should == '/auctions/test:3'
  end
  it "should include routes for auction_lots" do
    pending "haven't gotten around to implementing a fully restful auction lots setup"
    route_for(:controller=>'auction_lots', :action=>'index', :auction_id=>"auction:3").should == '/auctions/auction:3/lots'
    route_for(:controller=>'auction_lots', :action=>'show', :auction_id=>"auction:3", :id=>"lot:4").should == '/auctions/auction:3/lots/lot:4'
      
    params_from(:get, '/auctions/auction:3/lots').should == {:controller=>'auction_lots', :auction_id=>"auction:3", :action=>'index'}
    params_from(:get, '/auctions/auction:3/lots/lot:4').should == {:controller=>'auction_lots', :auction_id=>"auction:3", :id=>"lot:4", :action=>'show'}
  end
  
  describe "show" do
    before(:each) do
      get :show, :id=>"ocn171359880"
    end

    it "should load auction object" do
      assigns["auction"].should be_instance_of Auction
    end

    it "should load lots array (images from this sale)" do
      assigns["lots"].each {|lot| lot.should be_instance_of Hash  }
    end
  end
  

end
