require 'rails_helper'

# describe 'トップページ', type: :system do
#   describe 'Pickup表示' do
#     context 'ユーザーA(顧客)がログインしている時' do
#       before do
#         customer_a = FactoryBot.create(:customer, name: 'ユーザーA', email: 'a@example.com', password: 'password')
#         # ユーザーAでログインする
#         visit login_path
#         fill_in 'メールアドレス', with: customer_a.email
#         expect(page).to have_field 'メールアドレス', with: 'a@example.com'
#         fill_in 'パスワード', with: customer_a.password
#         click_button 'ログイン'
#       end
#     end
    
#     it '' do
#       # expect(page).to have_content 'ようこそ'
#     end
#   end
# end