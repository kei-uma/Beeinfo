class Layout < ApplicationRecord
  has_many :user_layouts  # 追記
    has_many :users, through: :user_layouts  # 追記
end
