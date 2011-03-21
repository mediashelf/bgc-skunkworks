require 'yaml'
class BGCIdentityResolver
  # @@map = YAML.load(File.open(File.join(Rails.root, "config/role_map_#{Rails.env}.yml")))

  class << self
    
    # Uses BGC Authorities service to resolve mappings between a BGC Identifier and other systems' identifiers
    # @param [String] bgc_id BGC Identifier to resolve
    # @param [Symbol, Array] target the target(s) to resolve ids for.  Can be a single Symbol or an Array of Symbols
    def resolve(bgc_id, target=nil)
      
    end
  end
  
  class UnknownIdentifierException < Exception
  end
end
