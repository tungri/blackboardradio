class AddUserToTweet < ActiveRecord::Migration[6.1]
  def change
    change_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
    end
  end
end
