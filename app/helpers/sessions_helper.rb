module SessionsHelper
  def current_staff
    @current_staff ||= Staff.find_by(staff_id: session[:staff_id])
  end

  def logged_in?
    !!current_staff
  end
  
  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end
  
  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id])
  end

  def logged_in_customer?
    !!current_customer
  end
end