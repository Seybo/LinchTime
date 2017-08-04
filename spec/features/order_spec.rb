# frozen_string_literal: true

require 'rails_helper'

feature 'Order creation' do
  before do
    @p1 = create(:person)
    @p2 = create(:person)
  end

  def create_orders
    @order1 = create(:order)
    @order2 = create(:order)
    @meal1 = create(:meal)
    @meal2 = create(:meal)
    create(:order_position, order: @order1, person: @p1, meal: @meal1)
    create(:order_position, order: @order1, person: @p2, meal: @meal1)
    create(:order_position, order: @order2, person: @p1, meal: @meal2)
    create(:order_position, order: @order2, person: @p2, meal: @meal2)
  end

  context 'valid form: order created' do
    scenario 'from input fields (favorites empty)' do
      visit root_path

      fill_in @p1.name, with: 'pizza'
      fill_in @p2.name, with: 'burger'
      click_on 'Create Order'

      expect(page).to have_content("#{@p1.name}: pizza")
      expect(page).to have_content("#{@p2.name}: burger")
    end

    scenario 'from input fields (favorites also filled)' do
      create_orders

      visit root_path
      expect(page).to have_select('order_order_positions_attributes_0_favorite', text: @meal1.name)
      select @meal2.name, from: 'order_order_positions_attributes_0_favorite'
      fill_in @p1.name, with: 'sushi'
      fill_in @p2.name, with: 'burger'
      click_on 'Create Order'

      expect(page).to have_content("#{@p1.name}: sushi")
      expect(page).to have_content("#{@p2.name}: burger")
    end

    scenario 'using favorites fields (input empty)' do
      create_orders

      visit root_path
      select @meal1.name, from: 'order_order_positions_attributes_0_favorite'
      select @meal2.name, from: 'order_order_positions_attributes_1_favorite'
      click_on 'Create Order'

      expect(page).to have_content("#{@p1.name}: #{@meal1.name}")
      expect(page).to have_content("#{@p2.name}: #{@meal2.name}")
    end
  end

  context 'invalid form: order not created' do
    scenario 'only one input field is filled in' do
      visit root_path

      fill_in @p1.name, with: 'pizza'
      click_on 'Create Order'

      expect(page).to_not have_content("#{@p1.name}: pizza")
      expect(page).to have_content("There was an error with your order placement. Please try again")
      expect(Order.count).to eq 0
    end

    scenario 'only one favorite field is filled in' do
      create_orders
      visit root_path

      select @meal1.name, from: 'order_order_positions_attributes_0_favorite'
      click_on 'Create Order'

      expect(page).to_not have_content("#{@p1.name}: #{@meal1.name}")
      expect(page).to have_content("There was an error with your order placement. Please try again")
      expect(Order.count).to eq 2
    end
  end
end
