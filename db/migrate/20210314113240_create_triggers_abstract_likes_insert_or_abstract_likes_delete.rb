# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersAbstractLikesInsertOrAbstractLikesDelete < ActiveRecord::Migration[6.1]
  def up
    create_trigger("abstract_likes_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("abstract_likes").
        after(:insert) do
      "UPDATE abstract_tweets SET likes_count = likes_count + 1 WHERE id = NEW.abstract_tweet_id;"
    end

    create_trigger("abstract_likes_after_delete_row_tr", :generated => true, :compatibility => 1).
        on("abstract_likes").
        after(:delete) do
      "UPDATE abstract_tweets SET likes_count = likes_count - 1 WHERE id = OLD.abstract_tweet_id;"
    end
  end

  def down
    drop_trigger("abstract_likes_after_insert_row_tr", "abstract_likes", :generated => true)

    drop_trigger("abstract_likes_after_delete_row_tr", "abstract_likes", :generated => true)
  end
end
