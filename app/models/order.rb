class Order < ApplicationRecord
  has_many :order_positions, dependent: :destroy

  accepts_nested_attributes_for :order_positions
end
