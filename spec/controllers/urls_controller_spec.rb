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

  describe "GET 'create'" do
    it "should returns http success" do
      get :create
      response.should be_success
      response.should render_template "create"
    end

    it "should returns success on json format" do
      get :create, :format => :json
      response.should be_success
    end
  end

  require File.expand_path('spec/spec_helper')

  describe "POST 'create'" do
    it "should return http success" do
      post :create
      response.should be_success
      response.should render_template "create"
    end
  end

end
