# == Schema Information
#
# Table name: edits_twitters
#
#  id               :integer          not null, primary key
#  edit_id          :integer
#  twitter_datum_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class EditsTwitterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
