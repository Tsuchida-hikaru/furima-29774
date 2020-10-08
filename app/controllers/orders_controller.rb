class OrdersController < ApplicationController

  def index
    @product = Product.new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_adress_params)
    if @order_address.valid?
      @order_address.save
      return redirect_to product_path
    else
      render action: :index
    end
  end

  private

  def order_adress_params
    params.require(:order_address).permit(:user, :product, :postal_code, :prefecture, :city, :address_number, :apartment_number, :phone_number)
  end

end
