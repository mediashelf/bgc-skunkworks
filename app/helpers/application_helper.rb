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
  
  
end
