require 'spec_helper'

describe Url do
  before :each do
    @url = Factory :url
  end
  
  it "should be valid" do
    @url.should be_valid
  end
  
  it "should embed many visits" do
    should embed_many :visits
  end
  
  describe "token" do        
    it "should deny duplicate" do
      @url.token = 'test'
      @url.save            
      url = Url.new :link => 'http://josemarluedke.com', :token => 'test'
      url.should_not be_valid
    end
    
    it "should be generate automatic token" do
      url = Url.create! link: "http://outherlink.com"
      url.save
      url.token.should_not be_empty
    end
  end
  
  describe "link" do
    it "require" do
      @url.link = nil
      @url.should_not be_valid
    end
    
    it "should not be valid" do 
      @url.link = 'www.com'
      @url.should_not be_valid
    end
    
    it "should be valid with http protocol" do
      @url.link = 'http://github.com/josemarluedke/URLShortener'
      @url.should be_valid
    end
    
    it "should be valid with https protocol" do
      @url.link = 'https://github.com/josemarluedke/URLShortener'
      @url.should be_valid
    end
    
    it "should be valid with git protocol" do
      @url.link = 'git://github.com/josemarluedke/URLShortener.git'
      @url.should be_valid
    end
    
    it "should be valid with svn protocol" do
      @url.link = 'svn://github.com/josemarluedke/URLShortener.git'
      @url.should be_valid
    end
    
    it "should be valid with ftp protocol" do
      @url.link = 'ftp://github.com/'
      @url.should be_valid
    end
    
    it "should deny duplicate" do
      @url.link = 'http://josemarluedke.com'
      @url.save
      url = Url.new :link => 'http://josemarluedke.com', :token => 'test'
      url.should_not be_valid
    end
  end
  
  describe "new visit" do
    it "should be create new visit" do
      @url.new_visit
      Url.first.visits.count.should eq 1
    end
    
    it "should have correct url_id" do
      @url.new_visit
      Url.first.visits.first.url eq @url
    end
  end
  
  describe "last visits" do
    it "should returns 20 visits" do
      21.times { |i| @url.new_visit :referral_link => i }
      @url.last_visits.count.should eq 20
    end
  end
end
