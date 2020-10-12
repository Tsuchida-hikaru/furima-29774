class OrdersController < ApplicationController
  before_action :set_product, only: [:index, :create]
  before_action :buyer_checer, only: [:index, :create]
  before_action :sold_checker, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_product # 商品情報を表示させるためのインスタンス変数を作成
    @product = Product.find(params[:product_id])
  end

  def buyer_checer # 出品者が商品購入ページへ直接アクセス出来ないようにする
    redirect_to root_path if user_signed_in? && current_user.id == @product.user_id
  end

  def sold_checker # 購入済み商品の購入ページに直接アクセス出来ないようにする
    redirect_to root_path if @product.order.present?
  end

  def order_address_params # order_addressモデルに引き渡すためのparamsをセット
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address_number, :apartment_number, :phone_number).merge(token: params[:token], price: @product.price, user_id: current_user.id, product_id: @product.id)
  end

  def pay_item # Pay.jpに送信するための処理を記述
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_address_params[:price],
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
