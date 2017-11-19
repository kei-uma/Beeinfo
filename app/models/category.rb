class Category < ApplicationRecord
  validates :name, uniqueness: true
  validates_presence_of :name
  has_many :edits
  has_many :user_categories
  has_many :users, through: :user_categories
end
