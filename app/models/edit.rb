class Edit < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :date
  validates_presence_of :text
  belongs_to :category
  has_many :twitter_datum, :through => :edits_twitter, :source => :twitter_data
  has_many :edits_twitter, foreign_key: 'edit_id'
  accepts_nested_attributes_for :edits_twitter, allow_destroy: true
end
