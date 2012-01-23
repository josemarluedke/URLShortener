require 'spec_helper'

describe UrlsController do

  describe "GET 'index'" do
    it "should returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should returns http success" do
      get :new
      response.should be_success
      assigns(:url).should be_new_record
    end

    it "should returns json format" do
      get :new, :format => "json"
      response.body.should eq(assigns(:url).to_json)
    end
  end

  describe "GET 'create'" do
    it "should returns http success" do
      get :create
      response.should be_success
    end
  end

end
