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

require 'test_helper'

class TwitterDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
