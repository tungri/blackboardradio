class AddCommentsCountToAbstractTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :abstract_tweets, :comments_count, :integer, null: false, default: 0
  end
end
