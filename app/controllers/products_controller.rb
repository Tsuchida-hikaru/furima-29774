class ProductsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  before_action :seller_checker, only: [:edit, :update, :destroy]

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

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to action: :index
    else
      render :show
    end
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_time_id, :user, :content, :image).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def seller_checker
    redirect_to action: :index if current_user.id != @product.user.id
  end
end
