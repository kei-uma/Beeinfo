# == Schema Information
#
# Table name: trend_twitters
#
#  id               :integer          not null, primary key
#  trend_id         :integer
#  twitter_datum_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TrendTwitter < ApplicationRecord
  belongs_to :trend
  belongs_to :twitter_datum, optional: true
end
