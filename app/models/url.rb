class Url
  include Mongoid::Document
  field :permalink, :type => String
  field :token, :type => String
  field :ip_address, :type => String
  field :created_at, :type => Time
  field :updated_at, :type => Time
end
