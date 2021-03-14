require_relative 'abstract_tweet'

class Comment < AbstractTweet
    belongs_to :user
    enum status: { published: 0, drafted: 1, deleted: 2 }
    belongs_to :tweet
end
