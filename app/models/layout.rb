class Layout < ApplicationRecord
  validates :layout, uniqueness: true
  validates_presence_of :layout
  has_many :user_layouts  # 追記
    has_many :users, through: :user_layouts  # 追記
end
