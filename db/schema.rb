# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_14_144635) do

  create_table "abstract_likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "abstract_tweet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["abstract_tweet_id", "user_id"], name: "index_abstract_likes_on_abstract_tweet_id_and_user_id", unique: true
    t.index ["abstract_tweet_id"], name: "index_abstract_likes_on_abstract_tweet_id"
    t.index ["user_id"], name: "index_abstract_likes_on_user_id"
  end

  create_table "abstract_tweets", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "status", default: 0
    t.integer "tweet_id"
    t.string "type", null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.text "attachments"
    t.index ["tweet_id", "user_id"], name: "index_abstract_tweets_on_tweet_id_and_user_id", unique: true
    t.index ["tweet_id"], name: "index_abstract_tweets_on_tweet_id"
    t.index ["user_id"], name: "index_abstract_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "abstract_likes", "abstract_tweets", on_delete: :cascade
  add_foreign_key "abstract_likes", "users", on_delete: :cascade
  add_foreign_key "abstract_tweets", "abstract_tweets", column: "tweet_id", on_delete: :cascade
  add_foreign_key "abstract_tweets", "users"
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
