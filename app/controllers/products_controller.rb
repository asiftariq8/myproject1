class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @products = Product.where.not(user: current_user).order(created_at: :desc)
    else
      @products = Product.all.order(created_at: :desc)
    end
  end


  def show
    @product = Product.find(params[:id])
    @products = Product.where.not(id: @product.id)
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to products_path, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.user == current_user
      @product.destroy
      redirect_to my_products_products_path, notice: "Product deleted."
    else
      redirect_to root_path, alert: "You are not authorized to delete this product."
    end
  end

  def my_products
    @products = current_user.products.order(created_at: :desc)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
  

  def authorize_user!
    redirect_to root_path, alert: "Not authorized." unless @product.user == current_user
  end



  def product_params
    params.require(:product).permit(:name, :price, :description, :category, images: [])
  end

end
