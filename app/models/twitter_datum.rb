class TwitterDatum < ApplicationRecord
  validates :tweet_id, uniqueness: true
  has_many :edits, :through => :edits_twitters
  has_many :edits_twitters, foreign_key: 'twitter_data_id'
end
