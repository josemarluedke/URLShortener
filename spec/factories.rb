require 'factory_girl'

Factory.define :url do |u|
    u.permalink 'http://josemarluedke.com'
    u.token 'site'
    u.ip_address '127.0.0.1'
end