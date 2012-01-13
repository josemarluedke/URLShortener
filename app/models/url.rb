class Url
    include Mongoid::Document
    include Mongoid::Timestamps
    field :permalink, :type => String
    field :token, :type => String
    field :ip_address, :type => String
    embeds_many :visits
    validates :permalink, :token, :presence => true, :uniqueness => true
    
    validate :permalink do
        if self.permalink !~ %r{^(http|https|git|svn)://[a-z0-9-]+(.[a-z0-9-]+)*(:[0-9]+)?(/.*)?$}
            errors.add :permalink, 'Invalid url'
        end
    end
    
    before_validation do
        if self.token.nil? or self.token.empty?
           self.token = random_token
        end
    end
    
    def random_token
        characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
        srand
        token = ''
        4.times do
            pos = rand(characters.length)
            token += characters[pos..pos]
        end
        token
    end
end
