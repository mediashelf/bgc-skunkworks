require "om/xml"
class AATSubject
  include OM::XML::Document
  
  set_terminology do |t|
    t.root(:path=>"Vocabulary")

    t.subject(:path=>"Subject", :namespace_prefix=>nil) {
      t.id_(:path=>{:attribute=>"Subject_ID"}, :namespace_prefix=>nil)
      t.parent_relationships(:path=>"Parent_Relationships", :namespace_prefix=>nil) {
        t.preferred_parent(:path=>"Preferred_Parent", :namespace_prefix=>nil) {
          t.id_(:path=>"Parent_Subject_ID", :namespace_prefix=>nil)
          t.parent_string(:path=>"Parent_String", :namespace_prefix=>nil)
        }        
      }
      t.descriptive_notes(:path=>"Descriptive_Notes", :namespace_prefix=>nil){
        t.note(:path=>"Descriptive_Note", :namespace_prefix=>nil) {
          t.text(:path=>"Note_Text", :namespace_prefix=>nil)
          t.language(:path=>"Note_Language", :namespace_prefix=>nil)
          t.contributors(:path=>"Note_Contributors", :namespace_prefix=>nil) {
            t.contributor(:path=>"Note_Contributor", :namespace_prefix=>nil) {
              t.id_(:path=>"Contributor_id", :namespace_prefix=>nil) {
              }
            }
          }
        }
      }
      t.terms(:path=>"Terms", :namespace_prefix=>nil) {
        t.preferred_term(:path=>"Preferred_Term", :namespace_prefix=>nil) {
          t.text(:path=>"Term_Text", :namespace_prefix=>nil)
        }
      }
    }
    
    # Convenience Terms (Proxy terms)
    t.description_text(:proxy=>[:subject, :descriptive_notes, :note, :text])
    t.id_(:proxy=>[:subject, :id])
  end
  
  def term_id
    term_values(:subject, :id).first
  end
  
  def preferred_term
    find_by_terms(:subject, :terms, :preferred_term, :text).text
  end
  
  def english_description
    find_by_terms("//Subject/Descriptive_Notes/Descriptive_Note[contains(Note_Language, 'English')]/Note_Text").text
  end
  
end
