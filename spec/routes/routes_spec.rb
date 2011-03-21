
describe Routes
  it "should include auctions" do
    route_for(:controller=>'auctions', :action=>'index').should == '/auctions'
    route_for(:controller=>'auctions', :action=>'show', :id=>"test:3").should == '/auctions/test:3'
      
    params_from(:get, '/auctions').should == {:controller=>'auctions', :action=>'index'}
    params_from(:get, '/auctions/test:3').should == {:controller=>'auctions', :id=>"test:3", :action=>'show'}

    auction_path("test:3").should == '/auctions/test:3'
  end
  it "should include auction auction_lots" do
    pending
    route_for(:controller=>'auction_lots', :action=>'index', :auction_id=>"test:3").should == '/auctions/auction:3/lots'
    route_for(:controller=>'auction_lots', :action=>'show', :auction_id=>"auction:3", :id=>"lot:4").should == '/auctions/auction:3/lots/lot:4'
      
    params_from(:get, '/auctions/auction:3/lots').should == {:controller=>'auction_lots', :action=>'index'}
    params_from(:get, '/auctions/auction:3/lots/lot:4').should == {:controller=>'auction_lots', :auction_id=>"test:3", :id=>"lot:4", :action=>'show'}

    auction_path("test:3").should == '/auctions/test:3'
  end
end

