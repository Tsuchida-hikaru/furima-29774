class ProductsController < ApplicationController
  before_action :move_to_index, except: [:index]

  def index
    @products = Product.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_time_id, :user, :content, :image).merge(user_id: current_user.id)
  end
end
