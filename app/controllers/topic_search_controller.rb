require "getty_vocabularies"
class TopicSearchController < CatalogController
  # Commented out apply_entity_filter until new marc records arrive so we can see sample results 
  # prepend_before_filter :apply_entity_filter, :only=>:index
  before_filter :load_aat_subject, :only=>:index
  
  def apply_entity_filter
    params[:f] ||= {}
    params[:f]["aat_subject"] = [params[:topic_id]]
  end
  
  def load_aat_subject
    @aat_subject = ::AATVocabularyService.instance.retrieve_subject(params[:topic_id])
  end
end