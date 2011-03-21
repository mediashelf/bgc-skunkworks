require "vocabularies/aat/aat_subject"
require "vocabularies/aat/aat_vocabulary_service"

require 'singleton'

class GettyVocabularies
  
  include Singleton
  
  attr_accessor :username, :password, :yaml_credentials
  
  def initialize
    @yaml_credentials = YAML.load(File.open(File.join(Rails.root, "config/getty_webservices.yml")))
    @username = @yaml_credentials["username"]
    @password = @yaml_credentials["password"]
  end
  
end