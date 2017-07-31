class OrdersController < ApplicationController
  def new
    @order = Order.new
    @persons = Person.all
    @persons.each do |p|
      @order.order_positions.new(person: p)
    end
  end
end
