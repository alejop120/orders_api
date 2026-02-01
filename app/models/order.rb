class Order < ApplicationRecord
  validates :customer_id, :product_name, :quantity, :price, presence: true
end
