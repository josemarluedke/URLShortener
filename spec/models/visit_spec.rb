require 'spec_helper'

describe Visit do
    before do
        @url = Factory :url
    end
    
    it "should be embedded in url" do
        should be_embedded_in :url
    end

    it "should require url_id" do
        visit = Visit.new :referral_link => 'http://josemarluedke.com', :ip_address => '127.0.0.1'
        visit.should_not be_valid
    end
    
    it "should be error when url does not exist" do
        visit = Visit.new :referral_link => 'http://josemarluedke.com', :ip_address => '127.0.0.1', :url => Visit.new
        visit.should_not be_valid
    end
    
    it "should be valid" do
        visit = Visit.new :referral_link => 'http://josemarluedke.com', :ip_address => '127.0.0.1', :url => @url
        visit.should be_valid
    end
end
