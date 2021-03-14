require_relative 'abstract_tweet'

class Tweet < AbstractTweet
    belongs_to :user
    enum status: { published: 0, drafted: 1, deleted: 2 }
    has_many :comments
end

