FactoryBot.define do
  factory :product do
    name   { 'レタス' }
    price  { 150 }
    status { true }
    description { 'とても美味しい' }
  end
end
