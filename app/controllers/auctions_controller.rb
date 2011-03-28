class AuctionsController < ApplicationController
  
  helper :auction
  
  def show
    @auction = Auction.load_instance(params[:id])
    params[:per_page] ||= "30"
    @lots = @auction.query_for_lots.paginate(:page=>params[:page], :per_page=>params[:per_page])
    
    @response, @document = [@auction.catalog_solr_response, @auction.catalog_solr_doc]
  end
  
end