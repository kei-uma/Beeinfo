class TwitterDatum < ApplicationRecord
  has_many :edits, through: :edits_twitters
  has_many :edits_twitters
end
