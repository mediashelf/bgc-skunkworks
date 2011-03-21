require 'singleton'
require "open-uri"
class AATVocabularyService
  include Singleton
  
  attr_accessor :base_uri, :username, :password
  
  def initialize
    @base_uri = 'http://vocabsservices.getty.edu/AATService.asmx'
    @username = GettyVocabularies.instance.username
    @password = GettyVocabularies.instance.password
  end
  
  def get_subject_xml(subject_id)
    aat = open("#{base_uri}/AATGetSubject?subjectID=#{subject_id}", :http_basic_authentication=>[username,password])
    aat.read
  end
end