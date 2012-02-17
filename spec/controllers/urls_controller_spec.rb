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
  
  describe "GET 'redirect'" do
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
    
    describe "visit" do
      it "should be create new visit when get 'redirect'" do
        get :redirect, :token => 'site'
        Url.first.visits.count.should eq 1
      end
      
      it "should have ip_address" do
        get :redirect, :token => 'site'
        Url.first.visits.first.ip_address.should eq "0.0.0.0"
      end
      
      it "should have referral_link" do
        request.env['HTTP_REFERER'] = 'http://twitter.com'
        get :redirect, :token => 'site'
        Url.first.visits.first.referral_link.should eq 'http://twitter.com'
      end
    end
  end
  
  describe "GET 'show'" do
    before :each do
      @url = Factory :url
    end
    
    it "should returns http success" do
      get :show, :token => 'site+'
      response.should be_success
      assigns(:url).should eq @url
      response.should render_template "show"
    end
    
    it "should returns success when it's json format" do
      get :show, :token => 'site+', :format => :json
      response.should be_success
    end
    
    it "should returns error on not found url" do
      get :show, :token => 'notfound+'
      response.status.should eq 404
      response.should render_template 'common/error'
    end
    
    it "should returns error on not found url when it's json format" do
      get :show, :token => 'notfound+', :format => :json
      response.status.should eq 404
    end
    
    it "should returns not found page when token is not informed" do
      get :show
      response.status.should eq 404
    end
  end
end
