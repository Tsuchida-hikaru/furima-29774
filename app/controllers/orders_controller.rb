class OrdersController < ApplicationController

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      return redirect_to product_path

  private

  def order_params
    params.require(:order).permit(:user, :product)
  end

end
