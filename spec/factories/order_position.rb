FactoryGirl.define do
  factory :order_position do
    order
    person
    meal
  end
end
