class TrendTwitter < ApplicationRecord
  belongs_to :trend
  belongs_to :twitter_datum
end
