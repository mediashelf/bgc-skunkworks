module AuctionHelper
  
  # Render html for an auction sale lot based on values hash from BGC Auction Lots service
  # @param [Hash] lot_values ex. {"lotNumber":"1861","description":["A LONGQUAN CELADON TRIPOD CENSER",""],"lotURL":"http://www.christies.com/LotFinder/lot_details.aspx?intObjectID=5271823","thumbnail":"http://www.christies.com/lotfinderimages/d52718/d5271823s.jpg"}}
  def render_lot(lot_values)
    result = image_tag(lot_values["thumbnail"], :alt=>lot_values["description"], :class => "auction_lot")
    return result
  end
end