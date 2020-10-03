require 'csv'

class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :price, presence: true,
                    numericality: { 
                      only_integer: true,
                      greater_than_or_equal_to: 100,
                      less_than: 100000
                    }
  
  has_many :cart_items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one  :stock, dependent: :destroy
  belongs_to :brand, optional: true

  accepts_nested_attributes_for :stock

  # 画像投稿の対応
  mount_uploader :image, ImageUploader
  
  # カラム名を指定(1行目)
  def self.csv_attributes
    ["name", "price", "created_at", "updated_at", "image"]
  end

  def self.import(file)
    # 受け取ったCSVファイルを行ごとに取り出す
    CSV.foreach(file.path, headers: true) do |row|
      # Product.newと同じ
      product = new
      # レコードをハッシュ形式にして格納する
      product.attributes = row.to_hash.slice(*csv_attributes)
      product.save
    end
  end
  
  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end
  
  def avg_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
  
end
