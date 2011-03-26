require "getty_vocabularies"
require "bgc_services/bgc_auction_sale_service"
# require "blacklight/solr_helper"
class Auction
  
  include Blacklight::SolrHelper
  
  attr_accessor :catalog_id, :catalog_solr_doc, :catalog_solr_response, :sale_number, :auction_house_sale_id, :auction_house_sale_url, :sale_json
  
  def initialize(catalog_id=nil)
    @catalog_id = catalog_id
    # if !new_id.nil?
    #   @auction_house = :christies
    #   @auction_house_id = BGCIdentityResolver.resolve_id(new_id, @auction_house)
    #   @aat = AATVocabularyService.retrieve_subject(:bgc_id=>new_id)
    #   extra_blacklight_controller_params = {}
    #   @solr_response, @solr_doc = get_solr_response_for_doc_id(new_id, extra_blacklight_controller_params)
    # end
  end
  
  # Create a new Auction object and load its catalog and sale info from solr and the BGC Auction service
  # @param [String] catalog_id id of the corresponding solr doc (ie. "ocn181946344")
  def self.load_instance(catalog_id)
    auction = self.new(catalog_id)
    auction.load_catalog_info
    auction.load_sale_info
    return auction
  end
  
  # Load catalog info from solr and sets the corresponding attributes catalog_solr_doc, catalog_solr_response
  # @param [String] catalog_id default to the value of @catalog_id
  # @param [Hash] extra_blacklight_controller_params extra params to pass into get_solr_response_for_doc_id
  # @return [Array] [solr_response, solr_doc]
  def load_catalog_info(catalog_id=@catalog_id, extra_blacklight_controller_params={})
    @catalog_solr_response, @catalog_solr_doc = get_solr_response_for_doc_id(catalog_id, extra_blacklight_controller_params)
    return [@catalog_solr_response, @catalog_solr_doc]
  end
  
  # Load sale info from AuctionSaleService and sets the corresponding attributes sale_id, sale_url
  # @param [String] catalog_id default to the value of @catalog_id
  # @return [Array] [sale_id, sale_url]
  def load_sale_info(catalog_id=@catalog_id)
    @sale_json = BGCAuctionSaleService.retrieve(catalog_id)
    @sale_number = @sale_json["saleNumber"]
    @auction_house_sale_id = @sale_json["intSaleID"]
    @auction_house_sale_url = @sale_json["saleURL"]
  end
  
end