class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :destroy]

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    
    if @review.save
      redirect_to shop_product_path(@review.product)
    else
      @product = Product.find_by(id: @review.product_id)
      @reviews = @product.reviews.order(id: :desc).page(params[:page]).per(3)
      flash.now[:danger] = '投稿に失敗しました。'
      render template: "shops/show"
    end
  end
  
  def destroy
    @review.destroy
    flash.now[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def show
  end

  private
  
  def set_review
    @review = Review.find(params[:id])
  end
  
  def review_params
    params.require(:review).permit(:product_id, :score, :content)
  end
end
