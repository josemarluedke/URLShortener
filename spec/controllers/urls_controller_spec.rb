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

    it "should returns success when it's json format" do
      get :new, :format => "json"
      response.should be_success
      response.body.should eq assigns(:url).to_json
    end
  end

  describe "POST 'create'" do
    it "should return http success" do
      post :create, :url => {:link => "http://url1.com"}
      response.should be_success
    end

    it "should returns success when it's json format" do
      post :create, :url => {:link => "http://josemarluedke.com"}, :format => :json
      response.should be_success
      response.body.should eq assigns(:url).to_json
    end
    
    describe "existing link" do
      before :each do
        @url = Factory :url
      end
      
      it "should returns existing record" do
        post :create, :url => {:link => "http://josemarluedke.com"}, :format => :json
        response.body.should eq @url.to_json
        response.should be_success
      end
    end
  end
  
  describe "GET 'redirect" do
    before :each do
      @url = Factory :url
    end
    
    it "should be redirect to url link" do
      get :redirect, :token => 'site'
      response.should redirect_to "http://josemarluedke.com"
    end
    
    it "should returns url data when it's json format" do
      get :redirect, :token => 'site', :format => :json
      response.body.should eq @url.to_json
      response.should be_success
    end
    
    it "should returns error on not found url" do
      get :redirect, :token => 'notfound'
      response.status.should eq 404
      response.should render_template 'common/error'
    end
    
    it "should returns error on not found url when it's json format" do
      get :redirect, :token => 'notfound', :format => :json
      response.status.should eq 404
    end
  end
  
  it "test" do
    { :get => '/site+' }.should route_to({:controller => "urls", :action => "show", :token => "site+"})
    response.should be_success
  end

  it "test 2" do
    { :get => '/sites' }.should route_to({:controller => "urls", :action => "redirect", :token => "sites"})
    response.should be_success
  end
  
end
