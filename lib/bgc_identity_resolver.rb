require "open-uri"
require 'json'
class BGCIdentityResolver
    
  # Uses BGC Authorities service to resolve mappings between a BGC Identifier and other systems' identifiers
  # @param [String] bgc_id BGC Identifier to resolve
  # @param [Symbol, Array] target the target(s) to resolve ids for.  Can be a single Symbol or an Array of Symbols
  def self.resolve_id(bgc_id, target=nil)
    identifiers = self.get_authority_json(bgc_id)["identifiers"]
    
    case target
      when Symbol
        result = identifiers[target.to_s]
      when String
        result = identifiers[target.to_s]
      when Array
        result = {}
        target.each do |t|
          result[t.to_s] = identifiers[t.to_s]
        end
    else
      result = identifiers
    end
        
    return result
  end
  
  def self.get_authority_json(bgc_id)
    begin
      JSON.parse( open("http://bgc.cloudant.com/authorities/#{bgc_id}").read )
    rescue OpenURI::HTTPError
      raise UnknownIdentifierException, "Could not find authority info for #{bgc_id}"
    end
  end
  
  class UnknownIdentifierException < Exception
  end
end
