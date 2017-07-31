class Meal < ApplicationRecord
  has_many :order_positions, dependent: :destroy

  validates :name, presence: true
end
