class Url
    include Mongoid::Document
    include Mongoid::Timestamps
    field :permalink, :type => String
    field :token, :type => String
    field :ip_address, :type => String
    embeds_many :visits
    
    validates :permalink, :token, :presence => true, :uniqueness => true
    validate :permalink do
        if permalink !~ %r{^(http|https|git|svn)://[a-z0-9-]+(.[a-z0-9-]+)*(:[0-9]+)?(/.*)?$}
            errors.add :permalink, 'Invalid url'
        end
    end
end
