# frozen_string_literal: true

require 'rails_helper'

feature 'Orders list display' do
  before do
    @p1 = create(:person)
    @p2 = create(:person)
    @order1 = create(:order)
    @order2 = create(:order)
    @order3 = create(:order)
    @meal1 = create(:meal)
    @meal2 = create(:meal)
  end

  def create_orders
    create(:order_position, order: @order1, person: @p1, meal: @meal1)
    create(:order_position, order: @order1, person: @p2, meal: @meal1)
    create(:order_position, order: @order2, person: @p1, meal: @meal2)
    create(:order_position, order: @order2, person: @p2, meal: @meal2)
    create(:order_position, order: @order3, person: @p1, meal: @meal2)
    create(:order_position, order: @order3, person: @p2, meal: @meal1)
  end

  scenario 'Shows all orders with recent first' do
    create_orders

    visit orders_path

    orders = page.all('.orders-list > div')
    expect(orders[0]).to have_content("Order #{@order3.id} from #{@order3.created_at.to_date}")
    expect(orders[2]).to have_content("Order #{@order1.id} from #{@order1.created_at.to_date}")
  end
end
