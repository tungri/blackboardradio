class AbstractTweet < ApplicationRecord
    belongs_to :user
    enum status: { published: 0, drafted: 1, deleted: 2 }
end
