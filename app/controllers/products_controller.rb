class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.order(id: :desc).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @product = Product.new
    @product.build_stock
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = '商品を登録しました。'
      redirect_to new_product_path
    else
      flash.now[:danger] = '商品の登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = '商品の修正をしました。'
      redirect_to products_path
    else
      flash.now[:danger] = '商品の修正に失敗しました。'
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash.now[:success] = '商品を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def import 
    Product.import(params[:file])  #現在のuserのtaskにimportを発動させる
    flash[:success] = 'ファイルをDBに取り込みました。'
    redirect_to products_path
  end
  
  def stock
    check = false
    
    @stock_items ||= stock_items_params.keys.each do |id|
      stock_item = Stock.find_or_create_by(product_id: id)
      stock_item.quantity += stock_items_params[id][:quantity].to_i

      if stock_items_params[id][:quantity].present?
        if stock_item.update_attributes(quantity: stock_item.quantity)
          check = true
        else
          flash.now[:warning] = '在庫の更新に失敗しました。'
          render :index and return
        end
      end
    end
    
    if check
      flash[:success] = '在庫の更新をしました。'
      redirect_to products_path
    else
      @products = Product.order(id: :desc).page(params[:page]).per(5)
      flash.now[:warning] = '値が変更されていません。'
      render :index
    end
  end

  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :price, :image, :status, :description, :brand_id, stock_attributes: [:quantity, :product_id])
  end
  
  def stock_items_params
    params.permit(stock_items: [:quantity])[:stock_items]
  end
end
