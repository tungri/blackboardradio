require_relative 'abstract_tweet'

class Tweet < AbstractTweet
    has_many :comments
end

