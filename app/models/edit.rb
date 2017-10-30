class Edit < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :date
  validates_presence_of :text
  belongs_to :category
  has_many :twitter_datum, :through => :edits_twitters, :source => :twitter_datum
  has_many :edits_twitters, foreign_key: 'edit_id'
  accepts_nested_attributes_for :edits_twitters, allow_destroy: true
end
