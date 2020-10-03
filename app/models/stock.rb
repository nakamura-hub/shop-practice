class Stock < ApplicationRecord
  belongs_to :product
  
  validates :quantity, numericality: {
                         only_integer: true,
                         greater_than_or_equal_to: 0,
                         less_than: 10000
                       } 
end
