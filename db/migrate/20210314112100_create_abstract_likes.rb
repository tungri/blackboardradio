class CreateAbstractLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :abstract_likes do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.references :abstract_tweet, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
