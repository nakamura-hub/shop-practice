FactoryBot.define do
  factory :customer do
    name     { 'テストユーザー' }
    email    { 'test@example.com' }
    zip      { '1111111' }
    address  { '日本県乙市1-2-3' }
    tel      { '12345678900' }
    password { 'password' }
  end
end
