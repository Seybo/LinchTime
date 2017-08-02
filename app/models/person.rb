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

  def favorite_meals
    OrderPosition.includes(:meal)
                 .where(person: self)
                 .group('meals.name')
                 .order('count_id desc')
                 .count('id')
  end
end
