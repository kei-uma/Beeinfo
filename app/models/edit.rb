class Edit < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :date
  validates_presence_of :text
  belongs_to :category
  has_many :twitter, through: :edits_twitters
  has_many :edits_twitters
end
