class OrdersController < ApplicationController

  def index
    order = Order.new
    @product = Product.find(product_params)
    @order_address = OrderAddress.new
  end

  def create
    binding.pry
    @order_address = OrderAddress.new(order_adress_params)
    if @order_address.valid?
      @order_address.save
      return redirect_to product_path
    else
      render action: :index
    end
  end

  private

  def product_params
    params.require(:product_id)
  end

  def order_adress_params
    params.require(:order_address).permit(:user, :product, :postal_code, :prefecture, :city, :address_number, :apartment_number, :phone_number, :product_id).merge(user_id: current_user.id)
  end

end
