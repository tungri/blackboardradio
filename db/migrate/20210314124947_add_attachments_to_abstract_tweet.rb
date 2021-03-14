class AddAttachmentsToAbstractTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :abstract_tweets, :attachments, :text
  end
end
