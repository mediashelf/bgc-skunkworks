require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TopicSearchController do

  it "should be routed for" do    
    # route_for(:controller=>'topics', :action=>'index').should == '/topics'
    route_for(:controller=>'topic_search', :action=>'index', :topic_id=>"300140808").should == '/topics/300140808'
      
    # params_from(:get, '/topics').should == {:controller=>'topics', :action=>'index'}
    params_from(:get, '/topics/300140808').should == {:controller=>'topic_search', :topic_id=>"300140808", :action=>'index'}

    topic_search_path("test:3").should == '/topics/test:3'
  end
  
  it "should be kind of CatalogController" do
    controller.should be_kind_of CatalogController
  end
  
  describe "show" do
    
    before(:each) do
      @mock_subject = AATSubject.new
      AATVocabularyService.instance.stub!(:retrieve_subject).with("300140808").and_return( @mock_subject )
      get :index, :topic_id=>"300140808"
    end
    
    it "should set facet param from entity id" do
      params[:f]["aat_subject"].should == ["300140808"]
    end
    
    it "should load auction object" do
      assigns["aat_subject"].should == @mock_subject
    end
    
    it "should behave like a blacklight catalog index action" do
      assigns["document_list"].should == []
      assigns["response"].should be_kind_of Hash
    end

  end
  

end
