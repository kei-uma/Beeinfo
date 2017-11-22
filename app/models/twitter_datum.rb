# == Schema Information
#
# Table name: twitter_data
#
#  id            :integer          not null, primary key
#  trend         :string(255)
#  tweet         :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tweet_id      :string(255)
#  image_url     :text(65535)
#  user          :string(255)
#  user_id       :string(255)
#  user_icon_url :text(65535)
#  tweet_time    :datetime
#  tweet_url     :text(65535)
#

class TwitterDatum < ApplicationRecord
  validates :tweet_id, uniqueness: true
  has_many :edits, :through => :edits_twitters
  has_many :edits_twitters, foreign_key: 'twitter_data_id'
  has_many :trends, :through => :trend_twitters
  has_many :trend_twitters, foreign_key: 'twitter_datum_id'
  accepts_nested_attributes_for :trend_twitters, allow_destroy: true
end
