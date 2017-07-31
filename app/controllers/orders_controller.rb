class OrdersController < ApplicationController
  def new
    @order = Order.new
    @persons = Person.all
    @persons.each do |p|
      @order.order_positions.new(person: p, meal: Meal.new)
    end
  end

  def create
    @order = Order.create

    if @order.update(order_params)
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:subject, order_positions_attributes: [:person_id, meal_attributes: [:name]])
  end
end
