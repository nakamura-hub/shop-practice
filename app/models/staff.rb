class Staff < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :staff_id, uniqueness: { case_sensitive: false }

  validate :password_lenght_HATI?

  has_secure_password
  
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
