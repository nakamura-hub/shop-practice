module OrdersHelper
  def order_status(status)
    if status == 0
      "未入金"
    elsif status == 1
      "入金済"
    elsif status == 2
      "完了"
    end
  end
  
  def postage(price_sum)
    if price_sum.to_i > 1000
      500
    else
      0
    end
  end
end