require 'factory_girl'

FactoryGirl.define do
  factory :url do
    link 'http://josemarluedke.com'
    token 'site'
    ip_address '127.0.0.1'
  end
end
