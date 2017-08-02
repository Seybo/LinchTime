FactoryGirl.define do
  factory :meal do
    name { Faker::Food.dish }
  end
end

