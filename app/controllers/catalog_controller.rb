class CatalogController
  require_dependency 'vendor/plugins/blacklight/app/controllers/catalog_controller.rb'
  
  #
  # Structures for format-specific setup in before_render filters
  #
  include ApplicationHelper # including the helper to give Controller access to document_partial_name method  
  before_render :format_specific_setup
  
  # Auction Filters and view helpers
  include AuctionFilters
  helper :auction  

  
  
  # Run format-specific setup methods
  # @example
  #   if the document's format is "auction", it will check for a method called auction_setup
  def format_specific_setup
    format = document_partial_name(@document)
    if self.respond_to?("#{format}_setup".to_sym)
      send("#{format}_setup".to_sym)
    else
      logger.debug "Didn't set up any format-specific info for #{format}.  To enable custom before_render callbacks for this format, define a filter method called #{format}_setup"
    end
    # case format
    # when "auction"
    #   setup_auction_info
    # else
    #   logger.debug "Didn't set up any format-specific info for #{format}"
    # end
  end
  
end