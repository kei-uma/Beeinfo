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

class EditsTwitter < ApplicationRecord
  belongs_to :edit, optional: true
  belongs_to :twitter_datum
end
