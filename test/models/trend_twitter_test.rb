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

require 'test_helper'

class TrendTwitterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
