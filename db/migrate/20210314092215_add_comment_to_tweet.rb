class AddCommentToTweet < ActiveRecord::Migration[6.1]
  def change
    change_table :tweets do |t|
      t.references :tweet, foreign_key: {on_delete: :cascade}
      t.string :type, null: false
    end
  end
end
