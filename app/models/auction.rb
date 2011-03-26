require "getty_vocabularies"
# require "blacklight/solr_helper"
class Auction
  
  include Blacklight::SolrHelper
  
  attr_accessor :solr_doc, :solr_response, :aat, :auction_house, :auction_house_id, :auction_house_sale_url
  
  def initialize(new_id=nil)
    if !new_id.nil?
      @auction_house = :christies
      @auction_house_id = BGCIdentityResolver.resolve_id(new_id, @auction_house)
      @aat = AATVocabularyService.retrieve_subject(:bgc_id=>new_id)
      extra_blacklight_controller_params = {}
      @solr_response, @solr_doc = get_solr_response_for_doc_id(new_id, extra_blacklight_controller_params)
    end
  end
  
  def self.load_instance(instance_id=nil)
    return self.new(instance_id)
  end
end