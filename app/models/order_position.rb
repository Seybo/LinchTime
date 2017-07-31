class OrderPosition < ApplicationRecord
  validates :person, :meal, :order, presence: true

  belongs_to :order
  belongs_to :person
  belongs_to :meal
end
