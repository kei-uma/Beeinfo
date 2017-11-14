class Edit < ApplicationRecord
  validates_presence_of :title
  belongs_to :category
  belongs_to :trend
  belongs_to :User
  has_many :twitter_datum, :through => :edits_twitters, :source => :twitter_datum
  has_many :edits_twitters, foreign_key: 'edit_id'
  accepts_nested_attributes_for :edits_twitters, allow_destroy: true
end
