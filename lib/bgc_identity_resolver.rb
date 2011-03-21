require "open-uri"
require 'json'
class BGCIdentityResolver
    
  # Uses BGC Authorities service to resolve mappings between a BGC Identifier and other systems' identifiers
  # @param [String] bgc_id BGC Identifier to resolve
  # @param [Symbol, Array] target the target(s) to resolve ids for.  Can be a single Symbol or an Array of Symbols
  def self.resolve(bgc_id, target=nil)
    self.get_authority_json(bgc_id)
  end
  
  def self.get_authority_json(bgc_id)
    JSON.parse( open("http://bgc.cloudant.com/authorities/#{bgc_id}").read )
  end
  
  class UnknownIdentifierException < Exception
  end
end
