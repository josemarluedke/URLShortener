require 'spec_helper'

describe "routes for url" do
  it "should be route for show url" do
    { :get => '/site+' }.should route_to({:controller => "urls", :action => "show", :token => "site+"})
  end

  it "should be route for redirect url" do
    { :get => '/site' }.should route_to({:controller => "urls", :action => "redirect", :token => "site"})
  end
end