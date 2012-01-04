require 'spec_helper'

describe Url do
    
    before do
        @url = Factory :url
    end
    
    describe "requires" do
        it "a permalink" do
            @url.permalink = nil
            @url.should_not be_valid
        end
        
        it "a token" do
            @url.token = nil
            @url.should_not be_valid
        end
    end
    
    describe "permalink" do
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
        
    end
    
    
    
end
