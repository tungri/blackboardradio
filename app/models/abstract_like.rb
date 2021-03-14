class AbstractLike < ApplicationRecord
  belongs_to :user
  belongs_to :abstract_tweet, dependent: :destroy

  trigger.after(:insert) do
    "UPDATE abstract_tweets SET likes_count = likes_count + 1 WHERE id = NEW.abstract_tweet_id"
  end

  trigger.after(:delete) do
    "UPDATE abstract_tweets SET likes_count = likes_count - 1 WHERE id = OLD.abstract_tweet_id"
  end
end
