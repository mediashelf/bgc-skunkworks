require 'vendor/plugins/blacklight/app/helpers/application_helper.rb'
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def application_name
    'BGC Skunkworks'
  end
  
  # collection of items to be rendered in the @sidebar2
  def sidebar2_items
    @sidebar2_items ||= []
  end
  
  # Overrridden to explicitly reference catalog views
  # Save function area for search results 'index' view, normally
  # renders next to title. Includes just 'Folder' by default.
  def render_index_doc_actions(document, options={})   
    content_tag("div", :class=>"documentFunctions") do
      "#{render(:partial => 'catalog/bookmark_control', :locals => {:document=> document}.merge(options))}
       #{render(:partial => 'catalog/folder_control', :locals => {:document=> document}.merge(options))}"
    end
  end
  
  # From hydra-head
  # Overriding Blacklight's render_document_partial
  # given a doc and action_name, this method attempts to render a partial template
  # based on the value of doc[:format]
  # if this value is blank (nil/empty) the "default" is used
  # if the partial is not found, the "default" partial is rendered instead
  def render_document_partial(doc, action_name, locals={})
    format = document_partial_name(doc)
    begin
      Rails.logger.debug("attempting to render #{format.pluralize}/_#{action_name}")
      render :partial=>"#{format.pluralize}/#{action_name}", :locals=>{:document=>doc}.merge(locals)
    rescue ActionView::MissingTemplate
      Rails.logger.debug("rendering default partial catalog/_#{action_name}_partials/default")
      render :partial=>"catalog/_#{action_name}_partials/default", :locals=>{:document=>doc}.merge(locals)
    end
  end
  
  
end
