require "getty_vocabularies"
class Auction
  
  include Blacklight::SolrHelper
  
  attr_accessor :solr_doc, :solr_response, :aat, :auction_house, :auction_house_id, :auction_house_sale_url
  
  def initialize(new_id=nil)
    if !new_id.nil?
      @auction_house_id = BGCIdentityResolver.resolve_id(new_id, :christies)
      @aat = AATVocabularyService.retrieve_subject(:bgc_id=>new_id)
      @solr_response, @solr_doc = solr_response_for_doc_id
    end
  end
  
  def self.load_instance(instance_id=nil)
    return self.new(instance_id)
  end
end