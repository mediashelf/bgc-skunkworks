require "om/xml"
class AATSubject
  include OM::XML::Document
  
  set_terminology do |t|
    t.root(:path=>"Vocabulary", :xmlns=>"http://www.loc.gov/mods/v3", :schema=>"http://www.loc.gov/standards/mods/v3/mods-3-2.xsd")

    t.subject(:path=>"Subject") {
      t.id_(:path=>{:attribute=>"Subject_ID"})
      t.parent_relationships(:path=>"Parent_Relationships") {
        t.preferred_parent(:path=>"Preferred_Parent") {
          t.id_(:path=>"Parent_Subject_ID")
          t.parent_string(:path=>"Parent_String")
        }        
      }
      t.descriptive_notes(:path=>"Descriptive_Notes"){
        t.note(:path=>"Descriptive_Note") {
          t.text(:path=>"Note_Text")
          t.language(:path=>"Note_Language")
          t.contributors(:path=>"Note_Contributors") {
            t.contributor(:path=>"Note_Contributor") {
              t.id_(:path=>"Contributor_id") {
              }
            }
          }
        }
      }
    }
    
    # Convenience Terms (Proxy terms)
    t.description_text(:proxy=>[:subject, :descriptive_notes, :note, :text])
    t.id_(:proxy=>[:subject, :id])
  end
  
end
