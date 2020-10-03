class SessionsController < ApplicationController
  def new_staff
  end

  def create_staff
    staff_id = params[:session][:staff_id]
    password = params[:session][:password]
    if login_staff(staff_id, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new_staff
    end
  end

  def destroy_staff
    session[:staff_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  def new_customer
  end

  def create_customer
    email = params[:session][:email]
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new_customer
    end
  end

  def destroy_customer
    if current_cart
      cart = Cart.find_by(id: current_cart.id)
      cart.destroy
      session[:cart_id] = nil
    end

    session[:customer_id] = nil
    flash[:success] = 'ログアウトしました。'

    redirect_to root_url
  end
  
  
  private

  def login_staff(staff_id, password)
    @staff = Staff.find_by(staff_id: staff_id)
    if @staff && @staff.authenticate(password)
      # ログイン成功
      session[:staff_id] = @staff.staff_id
      return true
    else
      # ログイン失敗
      return false
    end
  end
  
  def login(email, password)
    @customer = Customer.find_by(email: email)
    if @customer && @customer.authenticate(password)
      # ログイン成功
      session[:customer_id] = @customer.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
