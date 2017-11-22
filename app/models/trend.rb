# == Schema Information
#
# Table name: trends
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trend < ApplicationRecord
  has_many :twitter_data, :through => :trend_twitters
  has_many :trend_twitters, foreign_key: 'trend_id'
  has_many :edits
end
