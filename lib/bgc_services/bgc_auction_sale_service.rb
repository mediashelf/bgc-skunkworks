require "open-uri"
require 'json'
require "bgc_services/bgc_service"

class BGCAuctionSaleService
  
  # Uses BGC Auctions service to retrieve metadata about Auction Sales
  # @param [String] auction_catalog_id OCN Identifier for Auction Catalog record
  # @param [JSON] target the target(s) to resolve ids for.  Can be a single Symbol or an Array of Symbols
  def self.retrieve(auction_catalog_id)
    return self.get_sale_json(auction_catalog_id).first["value"]
  end
  
  def self.get_sale_json(auction_catalog_id)
    begin
      result = JSON.parse( open("http://bgc.cloudant.com/auctions/_design/views/_view/scipioControlNumber?key=%22#{auction_catalog_id}%22").read )
    rescue OpenURI::HTTPError
      raise BGCService::UnknownIdentifierException, "Could not find sale info for #{auction_catalog_id}"
    end
    if result["rows"].empty?
      raise BGCService::UnknownIdentifierException, "Could not find sale info for #{auction_catalog_id}"
    end
    return result["rows"]
  end
  
end
