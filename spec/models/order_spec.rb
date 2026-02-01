require "rails_helper"

RSpec.describe Order, type: :model do
  it "is valid with required attributes" do
    order = Order.new(
      customer_id: 1,
      product_name: "Lavado premium",
      quantity: 1,
      price: 20000,
      status: "created"
    )

    expect(order).to be_valid
  end

  it "is invalid without customer_id" do
    order = Order.new(product_name: "Test")

    expect(order).not_to be_valid
  end
end
