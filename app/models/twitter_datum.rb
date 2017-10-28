class TwitterDatum < ApplicationRecord
  has_many :edits, :through => :edits_twitter
  has_many :edits_twitter, foreign_key: 'twitter_data_id'
end
