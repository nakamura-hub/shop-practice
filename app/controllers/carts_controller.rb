class CartsController < ApplicationController
  before_action :set_cart_item, only: [:create ,:update, :destroy]

  def show
    @cart_items = current_cart.cart_items
  end

  # カートに商品追加
  def create
    initialize_cart
    
    @cart_item = current_cart.cart_items.build(product_id: params[:product_id]) if @cart_item.blank?
    # 商品の存在の否に関わらずインクリメント
    @cart_item.quantity += params[:quantity].to_i

    if @cart_item.save
      flash[:success] = "カートに#{@cart_item.product.name}を#{params[:quantity].to_i}個、追加しました。"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = '商品の追加に失敗しました。'
      render shop_product_path
    end
  end

  # カートの商品の数量を変更 or 削除
  def update
    check = false

    @cart_items ||= cart_items_params.keys.each do |id|
      cart_item = current_cart.cart_items.find_by(id: id)
      cart_item.quantity += cart_items_params[id][:quantity].to_i

      # チェックボックスがチェックされている場合は削除
      if cart_items_delete_params.include?(cart_item.id.to_s) && cart_items_delete_params.any?
        cart_item.destroy
        check = true
      # チェックボックスがチェックされていない場合は更新
      else
        cart_item.update_attributes(id: id, quantity: cart_item.quantity)
        check = true if cart_item.saved_change_to_quantity?
      end
    end

    if check
      flash[:success] = 'カートを更新しました。'
    else
      flash[:info] = '値が変更されていません。'
    end

    redirect_to current_cart
  end

  # カートから商品削除
  def destroy
    @cart_item.destroy
    
    if current_cart.cart_items.blank?
      cart = Cart.find_by(id: current_cart.id)
      cart.destroy
      session[:cart_id] = nil
      flash[:info] = 'カートが空になりました。'
      redirect_to shop_list_path
    else
      redirect_to current_cart
    end
  end
  
  # カートを空にする
  def destroy_all
    cart = Cart.find_by(id: current_cart.id)
    
    cart.destroy
    session[:cart_id] = nil
    redirect_to shop_list_path
    flash[:info] = 'カートを空にしました。'
  end

  private

  def set_cart_item
    if current_cart
      @cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
    end
  end
  
  def initialize_cart
    if current_cart
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @cart
    end
  end
  
  def cart_items_params
    params.permit(cart_items: [:quantity])[:cart_items]
  end
  
  def cart_items_delete_params
    params.permit(check: [])[:check]
  end
  
end
