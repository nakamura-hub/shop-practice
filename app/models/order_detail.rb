class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order
  
  # scopeでsearchメソッドを定義
  scope :search, -> (search_params) do
     # 検索フォームに値がなければ以下の手順は行わない
    return if search_params.blank?

    # 下記で定義しているscopeメソッドの呼び出し。メソッドチェーン
    keyword_search(search_params[:column_keyword], search_params[:value])
      .dete_from(search_params[:dete_from])
      .dete_to(search_params[:check_in_to])
  end
  
  # scopeを定義
  scope :keyword_search, -> (column_keyword, search_value) {
    case column_keyword
      when '0'
        all
      when '1'
        where('order_id = ?', search_value)
      when '2'
        where(order_id: Order.where('customer_id = ?', search_value).select(:id))
      when '3'
        where('product_id = ?', search_value)
    else
      OrderDetail.none
    end
  }
  scope :dete_from, -> (from) { where('? <= created_at', from) if from.present? }
  scope :dete_to, -> (to) { where('created_at <= ?', to) if to.present? }
  # scope :メソッド名 -> (引数) { SQL文 }
  # if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
end
