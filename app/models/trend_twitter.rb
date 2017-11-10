class TrendTwitter < ApplicationRecord
  belongs_to :trend
  belongs_to :twitter_datum, optional: true
end
