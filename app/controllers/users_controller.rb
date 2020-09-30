class UsersController < ApplicationController
  before_action :move_to_index, except: [:index]

  def index
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition_id, :delivery_fee_id, :perefecture_id, :shipping_time_id, :user)
  end
end
