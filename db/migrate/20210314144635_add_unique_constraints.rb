class AddUniqueConstraints < ActiveRecord::Migration[6.1]
  def change
    add_index :abstract_likes, [:abstract_tweet_id, :user_id], unique: true
    add_index :abstract_tweets, [:tweet_id, :user_id], unique: true
  end
end
