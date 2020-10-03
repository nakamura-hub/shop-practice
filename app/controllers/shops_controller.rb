class ShopsController < ApplicationController
  def index
    @products = Product.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews.order(id: :desc).page(params[:page]).per(3)
  end
end
