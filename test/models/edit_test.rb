# == Schema Information
#
# Table name: edits
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  date        :date
#  text        :text(65535)
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  trend_id    :integer
#  User_id     :integer
#

require 'test_helper'

class EditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
