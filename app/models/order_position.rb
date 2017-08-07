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
  attr_accessor :favorite

  belongs_to :order
  belongs_to :person
  belongs_to :meal

  accepts_nested_attributes_for :meal, :person

  validates :person, :meal, :order, presence: true
  validates_associated :meal, :person

  def autosave_associated_records_for_meal
    existed_meal = Meal.find_by_name(meal.name.strip.downcase)

    if existed_meal
      self.meal = existed_meal
    else
      meal.name.downcase!
      meal.save!
      self.meal_id = meal.id
    end
  end
end
