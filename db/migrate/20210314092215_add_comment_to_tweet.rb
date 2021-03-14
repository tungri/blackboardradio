class AddCommentToTweet < ActiveRecord::Migration[6.1]
  def change
    change_table :tweets do |t|
      t.references :tweet, foreign_key: true
      t.string :type, null: false
    end
  end
end
