class Trend < ApplicationRecord
  has_many :twitter_data, :through => :trend_twitters
  has_many :trend_twitters, foreign_key: 'trend_id'
  has_many :edits
end
