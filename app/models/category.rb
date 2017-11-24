# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  validates :name, uniqueness: true
  validates_presence_of :name
  has_many :edits
  has_many :user_categories
  has_many :users, through: :user_categories
end
