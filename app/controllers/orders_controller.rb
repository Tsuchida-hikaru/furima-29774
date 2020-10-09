class OrdersController < ApplicationController

  def index
    @product = Product.find(product_params)
    @order_address = OrderAddress.new
  end

  def create
    @product = Product.find(product_params)
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      Payjp.api_key = "sk_test_9f0087ff892e5beb907d82a1"
      Payjp::Charge.create(
        amount: order_address_params[:price],
        card: order_address_params[:token],
        currency: 'jpy'
      )
      @order_address.save
      return redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def product_params
    params.require(:product_id)
  end

  def order_address_params
    params.require(:order_address).permit(:user, :product, :postal_code, :prefecture_id, :city, :address_number, :apartment_number, :phone_number).merge(token: params[:token], price: @product.price, user_id: current_user.id, product_id: :product_id)
  end
end
