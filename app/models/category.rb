class Category < ApplicationRecord
  validates :name, uniqueness: true
  has_many :edits
  has_many :user_categories
  has_many :users, through: :user_categories
end
