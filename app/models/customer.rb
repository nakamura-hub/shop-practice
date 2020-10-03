class Customer < ApplicationRecord
  before_save { self.email.downcase! }
  
  validate :password_lenght_HATI?
  
  has_many :orders, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_product, through: :favorites, source: :product
  has_many :reviews, dependent: :destroy
  
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_TEL_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :tel, format: { with: VALID_TEL_REGEX }
  validates :zip, length: {minimum: 2, maximum: 10}
  validates :address, length: {minimum: 2, maximum: 50}

  has_secure_password
  
  def favorite(product)
    self.favorites.find_or_create_by(product_id: product.id)
  end
  
  def unfavorite(product)
    favorite = self.favorites.find_by(product_id: product.id)
    favorite.destroy if favorite
  end
  
  def bookmark?(product)
    self.favorites_product.include?(product)
  end
  

  private

  # 新規入力 or パスワード変更時のみ
  def password_lenght_HATI?
    if password
      errors.add(:password, 'は8文字以上で入力してください。') if password.length < 8
    else
      return
    end
  end
end
