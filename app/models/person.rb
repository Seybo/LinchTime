# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ApplicationRecord
  validates :name, presence: true

  has_many :order_positions, dependent: :destroy
  has_many :meals, through: :order_positions, dependent: :destroy

  def favorite_meals
    order_positions.includes(:meal)
                   .group('meals.name')
                   .order('count_id desc')
                   .count('id')
  end
end
