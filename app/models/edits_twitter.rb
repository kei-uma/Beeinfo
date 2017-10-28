class EditsTwitter < ApplicationRecord
  belongs_to :edit, optional: true
  belongs_to :twitter_datum
end
