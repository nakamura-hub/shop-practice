class ToppagesController < ApplicationController
  def index
    @products = Product.order(id: :desc).limit(6)
  end
end
