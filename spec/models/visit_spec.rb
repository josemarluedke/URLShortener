require 'spec_helper'

describe Visit do
  before :each do
    @url = Factory :url
  end
  
  it "should be embedded in url" do
    should be_embedded_in :url
  end

  it "should require url_id" do
    visit = create :url => nil
    visit.should_not be_valid
  end
  
  it "should be error when url does not exist" do
    visit = create :url => Visit.new
    visit.should_not be_valid
  end
  
  it "should be valid" do
    visit = create
    visit.should be_valid
  end
  
  describe "embedded in url " do
    before :each do
      @visit = create
    end
    
    it "url should have vists" do
      Url.first.visits.count.should eq 1
    end
    
    it "should be embedded with url" do
      @visit.url eq @url
    end
  end
  
  private
    def create options = {}
      Visit.create({
        :referral_link => 'http://josemarluedke.com',
        :ip_address => '127.0.0.1',
        :url => @url
      }.merge(options))
    end
end
