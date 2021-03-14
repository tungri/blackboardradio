require_relative 'abstract_tweet'

class Comment < AbstractTweet
  belongs_to :tweet

  trigger.after(:insert) do
    "UPDATE abstract_tweets SET comments_count = comments_count + 1 WHERE id = NEW.tweet_id"
  end

  trigger.after(:delete) do
    "UPDATE abstract_tweets SET comments_count = comments_count - 1 WHERE id = OLD.tweet_id"
  end
end
