module ApplicationHelper
  def price_tax(price)
    price = price.to_i * 1.10
    # "#{comma_price(price.floor)} 円（税込）"
    price.floor
  end
  
  def comma_price(price)
    # 0円の時は処理しない
    if (price != 0 && price.present?)
      "#{price.to_s(:delimited, delimiter: ',')}"
    else
      0
    end
  end
end
