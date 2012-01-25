require 'spec_helper'

describe UrlsController do

  describe "GET 'index'" do
    it "should returns http success" do
      get :index
      response.should be_success
      response.should render_template "index"
    end
  end

  describe "GET 'new'" do
    it "should returns http success" do
      get :new
      response.should be_success
      assigns(:url).should be_new_record
      response.should render_template "new"
    end

    it "should returns success on json format" do
      get :new, :format => "json"
      response.should be_success
      response.body.should eq(assigns(:url).to_json)
    end
  end

  describe "POST 'create'" do
    it "should return http success" do
      post :create, :url => {:link => "http://url1.com"}
      response.should be_success
    end

    it "should returns success on json format" do
      post :create, :url => {:link => "http://josemarluedke.com"}, :format => :json
      response.should be_success
      response.body.should eq(assigns(:url).to_json)
    end
    
    describe "existing link" do
      before :each do
        @url = Factory :url
      end
      
      it "should returns existing record" do
        post :create, :url => {:link => "http://josemarluedke.com"}, :format => :json
        response.body.should eq(@url.to_json)
        response.should be_success        
      end
      
    end
  end

end
