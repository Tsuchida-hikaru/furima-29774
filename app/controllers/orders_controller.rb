class OrdersController < ApplicationController
  before_action :set_product, only: [:index, :create]
  before_action :buyer_checer, only: [:index, :create]
  before_action :sold_checker, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render action: :index
    end
  end

  private


  def set_product
    @product = Product.find(params[:product_id])
  end

  def buyer_checer
    if user_signed_in? && current_user.id == @product.user_id
      redirect_to root_path
    elsif user_signed_in? == false
      redirect_to new_user_session_path
    end
  end

  def sold_checker
    if @product.order.present?
      redirect_to root_path
    end
  end

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address_number, :apartment_number, :phone_number).merge(token: params[:token], price: @product.price, user_id: current_user.id, product_id: @product.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_address_params[:price],
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
