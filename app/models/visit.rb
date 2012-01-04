class Visit
  include Mongoid::Document
  include Mongoid::Timestamps
  field :referral_link, :type => String
  field :ip_address, :type => String
  embedded_in :url
  validates_presence_of :url
  validates_associated :url
end
