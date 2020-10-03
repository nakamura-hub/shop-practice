module ProductsHelper
  def product_status(status, quantity)
    if status
      if quantity == 0
        content_tag(:span, class: 'badge badge-warning') do
          "売り切れ"
        end
      else
        content_tag(:span, class: 'badge badge-success') do
          "販売中"
        end
      end
    else
      content_tag(:span, class: 'badge badge-danger') do
        "販売停止"
      end
    end
  end
end