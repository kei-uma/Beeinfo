class Trend < ApplicationRecord
  has_many :twitter_datum, :through => :trend_twitters
  has_many :twitter_datum, foreign_key: 'twitter_data_id'
end
