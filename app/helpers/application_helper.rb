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
end
