class Person < ApplicationRecord
  validates :name, presence: true

  has_many :order_positions, dependent: :destroy
end
