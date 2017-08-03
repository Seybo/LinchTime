# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord
  has_many :order_positions, dependent: :destroy

  accepts_nested_attributes_for :order_positions

  scope :recent_first, -> { order('created_at desc') }
end
