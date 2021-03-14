class ChangeTweetsTableName < ActiveRecord::Migration[6.1]
  def change
    rename_table :tweets, :abstract_tweets
  end
end
