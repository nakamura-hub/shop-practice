require 'rails_helper.rb'

RSpec.describe Customer, type: :model do

  it "姓、名、メール、パスワードがある場合、有効である" do
　　 # userのそれぞれのカラムに対して値を入れてオブジェクト化する
    customer = Customer.new(
      id: 100,
      name: '稼働　一',
      email: 'test100@test.test',
      zip: '1111111',
      address: '日本県乙市1-2-3',
      tel: '11111111',
      password: '11111111',
      password_confirmation: '11111111'
     )
     # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
     expect(customer).to be_valid
  end
  it "名がない場合、無効である"
  it "姓がない場合、無効である" 
  it "メールアドレスがない場合、無効である" 
  it "重複したメールアドレスの場合、無効である"
  it "パスワードがない場合、無効である"

end