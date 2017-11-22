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

class Edit < ApplicationRecord
  validates_presence_of :title
  belongs_to :category
  belongs_to :trend
  belongs_to :User
  has_many :twitter_datum, :through => :edits_twitters, :source => :twitter_datum
  has_many :edits_twitters, foreign_key: 'edit_id'
  accepts_nested_attributes_for :edits_twitters, allow_destroy: true
end
