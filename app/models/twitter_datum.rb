class TwitterDatum < ApplicationRecord
  validates :tweet_id, uniqueness: true
  has_many :edits, :through => :edits_twitters
  has_many :edits_twitters, foreign_key: 'twitter_data_id'
  has_many :trends, :through => :trend_twitters
  has_many :trend_twitters, foreign_key: 'twitter_datum_id'
  accepts_nested_attributes_for :trend_twitters, allow_destroy: true
end
