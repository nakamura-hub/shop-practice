class CustomersController < ApplicationController
  before_action :require_customer_logged_in, only: [:show]
  before_action :correct_customer, only: [:show, :edit, :update, :destroy]
  
  def index
    @customers = Customer.order(id: :desc).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    params[:customer][:born] = born_join
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = '会員登録に成功しました。'
      redirect_to root_url
    else
      flash[:danger] = '会員登録に失敗しました。'
      render :new
    end
  end

  def edit
    # # DateTime.parse(@customer.born)
    # # 2020-01-01
    
    # # year  = @customer.born[0..3]
    # # month = @customer.born[5..6]
    # # date  = @customer.born[8..10]
    # # @customer.born = year + month + date
    # @customer.born.to_date
    # logger.debug "日付: #{@customer.born}"
  end

  def update
    @customer = Customer.find(params[:id])
    
    params[:customer][:born] = born_join
    if @customer.update(customer_params)
      flash[:success] = '編集が完了しました。'
      redirect_to @customer
    else
      flash[:danger] = '編集が失敗しました。'
      render :edit
    end

  end

  def destroy
    if current_cart
      cart = Cart.find_by(id: current_cart.id)
      cart.destroy
      session[:cart_id] = nil
    end

    
    @customer.destroy
    flash[:success] = '退会が完了いたしました。'
    redirect_to root_url
  end
  
  def orders
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page]).per(5)
  end
  
  def order_details
    @order = Order.find(params[:id])
    if @order.customer_id != current_customer.id
      redirect_back(fallback_location: root_path)
    end
  end
  
  def favorites
    @favorites = current_customer.favorites_product.page(params[:page]).per(6)
  end
  
  def reviews
    @reviews = current_customer.reviews.page(params[:page]).per(6)
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation, :zip, :address, :tel, :gender, :born)
  end
  
  def correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to current_customer
    end
  end

  def born_join
    born = params[:born]

    if born["born(1i)"].empty? && born["born(2i)"].empty? && born["born(3i)"].empty?
      return
    end

    Date.new born["born(1i)"].to_i,born["born(2i)"].to_i,born["born(3i)"].to_i
  end
end
