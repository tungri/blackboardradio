class AddUniqueConstraints < ActiveRecord::Migration[6.1]
  def change
    add_index :abstract_likes, [:abstract_tweet, :user], unique: true
    add_index :abstract_tweets, [:tweet, :user], unique: true
  end
end
