require "open-uri"
require 'json'
require "bgc_services/bgc_service"

class BGCAuctionSaleService
    
  # Uses BGC Authorities service to resolve mappings between a BGC Identifier and other systems' identifiers
  # @param [String] bgc_id BGC Identifier to resolve
  # @param [Symbol, Array] target the target(s) to resolve ids for.  Can be a single Symbol or an Array of Symbols
  # def self.resolve_id(bgc_id, target=nil)
  #   identifiers = self.get_authority_json(bgc_id)["identifiers"]
  #   
  #   case target
  #     when Symbol
  #       result = identifiers[target.to_s]
  #     when String
  #       result = identifiers[target.to_s]
  #     when Array
  #       result = {}
  #       target.each do |t|
  #         result[t.to_s] = identifiers[t.to_s]
  #       end
  #   else
  #     result = identifiers
  #   end
  #       
  #   return result
  # end
  
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
