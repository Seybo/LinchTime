# frozen_string_literal: true

require 'rails_helper'

describe Person do
  it { should validate_presence_of(:name) }

  let(:person) { create(:person) }

  it 'selects favorites' do
    meal1 = create(:meal)
    meal2 = create(:meal)
    meal3 = create(:meal)

    2.times { create(:order_position, person: person, meal: meal2) }
    3.times { create(:order_position, person: person, meal: meal3) }
    create(:order_position, person: person, meal: meal1)

    expect(person.favorite_meals).to eq(meal3.name => 3, meal2.name => 2, meal1.name => 1)
  end
end
