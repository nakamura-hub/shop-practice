require 'csv'

class Order < ApplicationRecord
  validates :zip, presence: true, length: {minimum: 2, maximum: 10}
  validates :address, presence: true, length: {minimum: 2, maximum: 50}
  
  
  # 外部キーがnullでもOK
  belongs_to :customer, optional: true
  has_many :order_details, dependent: :destroy

  # カラム名を指定(1行目)
  def OrderDetail.csv_attributes
    [
      '注文コード',
      '注文日時',
      '会員番号',
      '顧客名',
      'メールアドレス',
      '郵便番号',
      '住所',
      '電話番号',
      '商品番号',
      '商品名',
      '価格',
      '数量'
    ]
  end

  # CSV形式で注文明細を出力できるようにする
  # contoller内でOrderDetailのインスタンスを生成しているため
  # クラスメソッドとして指定
  def OrderDetail.generate_csv
    CSV.generate(headers: true) do |csv|
      # カラム名を1行目として代入
      csv << csv_attributes
      # 注文明細を1レコードずつ取り出す
      all.each do |order_detail|
        # 取り出したいカラムを指定
        column_values = [
          order_detail.order.id,
          order_detail.order.created_at.to_s(:datetime_jp),
          order_detail.order.customer_id,
          order_detail.order.name,
          order_detail.order.email,
          order_detail.order.zip,
          order_detail.order.address,
          order_detail.order.tel,
          order_detail.product_id,
          order_detail.product.name,
          order_detail.product.price,
          order_detail.quantity,
        ]
        # カラムの値を代入していく
        csv << column_values
      end
    end
  end
end
