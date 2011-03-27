require "open-uri"
require 'json'
require "bgc_services/bgc_service"

class BGCAuctionLotService
  
  # Uses BGC Auction Lots service to retrieve a list of lots associated with a particular sale
  # @param [String] auction_sale_id Auction house's internal sale ID
  # @param [JSON] target the target(s) to resolve ids for.  Can be a single Symbol or an Array of Symbols
  def self.retrieve(auction_sale_id)
    return self.get_sale_json(auction_sale_id)
  end
  
  def self.get_sale_json(auction_sale_id)
    begin
      result = JSON.parse( open("http://bgc.cloudant.com/auction_lots/_design/views/_view/intSaleID?key=#{auction_sale_id}").read )
    rescue OpenURI::HTTPError
      raise BGCService::UnknownIdentifierException, "Could not find lots corresponding to saleID: #{auction_sale_id}"
    end
    if result["rows"].empty?
      raise BGCService::UnknownIdentifierException, "Could not find lots corresponding to saleID: #{auction_sale_id}"
    end
    return result["rows"]
  end
  
end
