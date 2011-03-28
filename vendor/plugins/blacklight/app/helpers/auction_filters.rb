module AuctionFilters
  
  
  def auction_setup
    setup_auction_info
  end
  
  def setup_auction_info
    logger.debug "setting up auction info"
    @auction = Auction.load_instance(params[:id])
    params[:per_page] ||= "30"
    @lots = @auction.query_for_lots.paginate(:page=>params[:page], :per_page=>params[:per_page])
  end
  
end