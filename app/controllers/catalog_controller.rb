class CatalogController
  require_dependency 'vendor/plugins/blacklight/app/controllers/catalog_controller.rb'
  
  include AuctionFilters
  
  # after_filter :setup_auction_info
  before_render_filters << :setup_auction_info
  helper :auction
  
end