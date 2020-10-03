class FavoritesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    current_customer.favorite(@product)
  end

  def destroy
    @product = Product.find(params[:product_id])
    current_customer.unfavorite(@product)
  end
end
