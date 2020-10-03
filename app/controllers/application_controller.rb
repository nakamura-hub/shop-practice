class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_staff_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def require_customer_logged_in
    unless logged_in_customer?
      redirect_to login_customer_url
    end
  end
end
