class OrdersController < ApplicationController
  def new
    @order = Order.new
    Person.all.each { |p| @order.order_positions.new(person: p, meal: Meal.new) }
  end

  def index
    @orders = Order.includes(order_positions: [:person, :meal]).recent_first
  end

  def create
    if Order.new.update_attributes(order_params)
      redirect_to orders_path, notice: 'Your order is being cooked...'
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

  def check_favorites(prms)
    prms[:order_positions_attributes].each_pair do |position, details|
      favorite = details['favorite']
      typed_in = prms[:order_positions_attributes][position][:meal_attributes][:name]

      next if favorite.blank? || typed_in.present?

      prms[:order_positions_attributes][position][:meal_attributes][:name] = favorite
    end
    prms
  end
end
