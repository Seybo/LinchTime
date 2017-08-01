# == Schema Information
#
# Table name: order_positions
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  meal_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#

class OrderPosition < ApplicationRecord
  belongs_to :order
  belongs_to :person
  belongs_to :meal

  accepts_nested_attributes_for :meal

  validates :person, :meal, :order, presence: true

  def autosave_associated_records_for_meal
    self.meal = Meal.find_by_name(meal.name) || meal
    self.meal.save!
  end
end
