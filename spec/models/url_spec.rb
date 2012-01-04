require 'spec_helper'

describe Url do
    
    before do
        @url = Factory :url
    end
    
    describe "token" do
        it "requere" do
            @url.token = nil
            @url.should_not be_valid
        end
        
        it "should deny duplicate" do
            @url.token = 'test'
            @url.save
            url = Url.new :permalink => 'http://josemarluedke.com', :token => 'test'
            url.should_not be_valid
        end
    end
    
    describe "permalink" do
        it "requere" do
            @url.permalink = nil
            @url.should_not be_valid
        end
        
        it "should not be valid" do 
            @url.permalink = 'www.com'
            @url.should_not be_valid
        end
        
        it "should be valid with http protocol" do
            @url.permalink = 'http://github.com/josemarluedke/URLShortener'
            @url.should be_valid
        end
        
        it "should be valid with https protocol" do
            @url.permalink = 'https://github.com/josemarluedke/URLShortener'
            @url.should be_valid
        end
        
        it "should be valid with git protocol" do
            @url.permalink = 'git://github.com/josemarluedke/URLShortener.git'
            @url.should be_valid
        end
        
        it "should be valid with svn protocol" do
            @url.permalink = 'svn://github.com/josemarluedke/URLShortener.git'
            @url.should be_valid
        end
        
        it "should deny duplicate" do
            @url.permalink = 'http://josemarluedke.com'
            @url.save
            url = Url.new :permalink => 'http://josemarluedke.com', :token => 'test'
            url.should_not be_valid
        end
    end
    
    
    
end
