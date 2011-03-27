class AuctionsController < ApplicationController
  
  def show
    @auction = Auction.load_instance(params[:id])
  end
  
end