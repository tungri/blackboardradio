# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersAbstractTweetsInsertOrAbstractTweetsDelete < ActiveRecord::Migration[6.1]
  def up
    create_trigger("abstract_tweets_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("abstract_tweets").
        after(:insert) do
      "UPDATE abstract_tweets SET comments_count = comments_count + 1 WHERE id = NEW.tweet_id;"
    end

    create_trigger("abstract_tweets_after_delete_row_tr", :generated => true, :compatibility => 1).
        on("abstract_tweets").
        after(:delete) do
      "UPDATE abstract_tweets SET comments_count = comments_count - 1 WHERE id = OLD.tweet_id;"
    end
  end

  def down
    drop_trigger("abstract_tweets_after_insert_row_tr", "abstract_tweets", :generated => true)

    drop_trigger("abstract_tweets_after_delete_row_tr", "abstract_tweets", :generated => true)
  end
end
