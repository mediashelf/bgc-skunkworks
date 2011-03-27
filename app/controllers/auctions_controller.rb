class AuctionsController < ApplicationController
  
  def show
    @auction = Auction.load_instance(params[:id])
    @response, @document = [@auction.catalog_solr_response, @auction.catalog_solr_doc]
  end
  
end