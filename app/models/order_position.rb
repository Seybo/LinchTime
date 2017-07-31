class OrderPosition < ApplicationRecord
  validates :person, :meal, presence: true

  belongs_to :person
  belongs_to :meal
end
