class Film < ApplicationRecord
  has_one_attached :poster

  validates :title, presence: true
  validates :publishing_year, presence: true, numericality: { only_integer: true }
end
