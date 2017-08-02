class OrdersController < ApplicationController
  def new
    @order = Order.new
    @persons = Person.all
    @persons.each do |p|
      @order.order_positions.new(person: p, meal: Meal.new)
    end
  end

  def create
    if Order.new.update(order_params)
      redirect_to root_path, notice: 'Your order is being cooked...'
    else
      redirect_to root_path, alert: 'There was an error with your order placement. Please try again'
    end
  end

  private

  def order_params
    permitted_params =
      params.require(:order)
            .permit(:subject, order_positions_attributes: [:person_id, :favorite,
                                                           meal_attributes: [:name, :favorite]])
    check_favorites(permitted_params)
  end

  def check_favorites(permitted_params)
    permitted_params[:order_positions_attributes].each_pair do |position, details|
      favorite = details['favorite']
      typed_in = permitted_params[:order_positions_attributes][position][:meal_attributes][:name]

      next if favorite.blank? || typed_in

      permitted_params[:order_positions_attributes][position][:meal_attributes][:name] = favorite
    end
    permitted_params
  end
end
