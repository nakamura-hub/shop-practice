FactoryBot.define do
  factory :review do
    content { 'テストを書く' }
    score   { 1 }
    customer
  end
end
