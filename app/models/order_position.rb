class OrderPosition < ApplicationRecord
  belongs_to :order
  belongs_to :person
  belongs_to :meal

  accepts_nested_attributes_for :meal

  validates :person, :meal, :order, presence: true
end
