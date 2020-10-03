class OrdersController < ApplicationController
  before_action :cart_nil?, only: [:create, :new, :confirm]
  
  def index
    @search_params = order_details_search_params
    @order_details = OrderDetail.order(order_id: :desc).page(params[:page]).per(7)
  end

  def new
    @customer = Customer.find_by(id: session[:customer_id])
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id if logged_in_customer?
    if @order.save
      current_cart.cart_items.each do |cart_item|
        order_details = @order.order_details.build
        order_details.order_id = @order.id
        order_details.product_id = cart_item.product_id
        order_details.price = cart_item.product.price
        order_details.quantity = cart_item.quantity

        order_details.save
        
        product = Product.find_by(id: cart_item.product_id)
        product.stock.quantity -= cart_item.quantity
        product.stock.quantity = 0 if product.stock.quantity < 0
        product.save
        
      end

      cart = Cart.find_by(id: current_cart.id)
      # 購入後カートを削除(セッションも)
      cart.destroy
      session[:cart_id] = nil

      flash[:success] = 'ご購入しました。'
      redirect_to thanks_order_path(@order.id)
    else
      flash.now[:danger] = 'ご購入できませんでした。'
      render :confirm
    end
  end

  def edit
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(status: order_params[:status])
      redirect_to orders_path
    else
      render orders_path
    end
  end

  def destroy
  end

  def confirm
    @customer = Customer.find_by(id: session[:customer_id])
    

    if @customer.update(customer_params)
      # 変更された場合のみメッセージ追加
      if @customer.saved_changes?
        flash[:success] = 'お客様情報を変更しました。'
      end
    else
      flash.now[:danger] = 'お客様情報を変更できませんでした。'
      render :new
    end
    
    @order = Order.new(
      name:    customer_params[:name],
      email:   customer_params[:email],
      zip:     customer_params[:zip],
      address: customer_params[:address],
      tel:     customer_params[:tel]
    )
    render :new if @order.invalid?
  end

  def thanks
    @order = Order.find(params[:id])
  end
  
  def export
    @search_params = order_details_search_params
    @order_details = OrderDetail.search(@search_params).includes(:order).order(order_id: :desc)

    # URLのformatによって処理を変える
    respond_to do |format|
      # html形式の場合の処理
      format.html
      # csv形式の場合の処理
      # send_dataでダウンロード
      format.csv { send_data @order_details.generate_csv, filename: "注文明細-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
    
    flash[:success] = 'ファイルをダウンロードしました。'
  end
  
  def search
    @search_params = order_details_search_params
    if @search_params[:column_keyword] != '0'
      @order_details = OrderDetail.search(@search_params).includes(:order).order(order_id: :desc).page(params[:page]).per(10)
    else
      @order_details = OrderDetail.all.order(order_id: :desc).page(params[:page]).per(10)
      @search_params[:value] = ''
      @search_params[:dete_from] = ''
      @search_params[:dete_to] = ''
    end
    render :index
  end

  private
  
  def order_params
    params.require(:order).permit(:name, :email, :zip, :address, :tel, :customer_id, :status, :sum)
  end
  
  def customer_params
    params.require(:customer).permit(:name, :email, :zip, :address, :tel, :gender, :born)
  end
  
  def cart_nil?
    
    unless current_cart
      flash[:danger] = 'カートが空です'
      redirect_to current_cart and return
    end
  end
  
  def order_details_search_params
    params.fetch(:search, {}).permit(:column_keyword, :value, :dete_from, :dete_to)
    #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
    #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  end
end
