#
# Custom before_render callback implementation
#
module BeforeRenderCallbacks

  # Class Methods -- These methods will be available on classes that include this Module 
  
  module ClassMethods
    
    # Add a before_render filter to the Class
    def before_render(filter)
      self.before_render_filters << filter
    end

    # Access to CatalogController.before_render_filters
    # @example
    #   before_render_filters << :setup_auction_info
    def before_render_filters
      @@before_render_filters ||= []
    end
    
  end

  # Instance Methods -- These methods will be available on instances of classes that include this module
  
  attr_accessor :ox_namespaces
  
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  
  # Run all of the before_render_filters set on the class
  # Filters can be either Symbols corresponding to instance methods or blocks
  # You have to put this into any methods that you want to run your before_render filters. You should put it immediately before the _render_ block in your code.
  # @example
  #   def show
  #     @response, @document = get_solr_response_for_doc_id    
  #     respond_to do |format|
  #       format.html {setup_next_and_previous_documents}
  #   
  #       run_before_render_filters
  #
  #      @document.export_formats.each_key do | format_name |
  #        format.send(format_name.to_sym) { render :text => @document.export_as(format_name) }
  #       end
  #   
  #     end
  #   end
  def run_before_render_filters
    self.class.before_render_filters.each do |filter| 
      case filter
      when Proc
        filter.call
      when Symbol
        if self.respond_to?(filter) 
          self.send(filter)
        else
          logger.debug "skipping before_render_filter #{filter.inspect} because there is no method by that name"
        end
      else
        logger.debug "skipping before_render_filter #{filter.inspect}.  Only blocks and Symbols accepted"
      end 
    end
  end
end