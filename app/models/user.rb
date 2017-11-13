class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_categories
  has_many :categories, through: :user_categories
  accepts_nested_attributes_for :user_categories, allow_destroy: true
end
