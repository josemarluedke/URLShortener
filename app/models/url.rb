class Url
  include Mongoid::Document
  include Mongoid::Timestamps
  field :link, :type => String
  field :token, :type => String
  field :ip_address, :type => String
  field :custom, :type => Boolean, :default => false
  embeds_many :visits
  validates :link, :token, :presence => true, :uniqueness => true
  
  validate :link do
    if self.link !~ %r{^(http|https|git|svn)://[a-z0-9-]+(.[a-z0-9-]+)*(:[0-9]+)?(/.*)?$}
      errors.add :link, 'Invalid url'
    end
  end
  
  before_validation do
    if self.token.nil? or self.token.empty?
      self.token = generate_token Url.count(conditions: {:custom => false})
    else
      self.custom = true
    end
    
  end
  
  private
    def generate_token num
      token = ShortUrlTokenGenerator::generate num
      if Url.count(conditions: {:token => token}) > 0
        token = generate_token num + 1
      end
      token
    end
end
