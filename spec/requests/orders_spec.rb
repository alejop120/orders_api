RSpec.describe "Orders API", type: :request do
  describe "POST /orders" do
    before do
      # Mock HTTP call to Customer Service
      allow(CustomerClient).to receive(:fetch)
                                 .with("1")
                                 .and_return({ "id" => 1 })

      # Mock RabbitMQ publisher
      allow(OrderEventPublisher).to receive(:publish)
    end

    it "creates an order successfully" do
      post "/orders", params: {
        order: {
          customer_id: 1,
          product_name: "Lavado premium",
          quantity: 1,
          price: 20000,
          status: "created"
        }
      }

      expect(response).to have_http_status(:created)
      expect(Order.count).to eq(1)
    end
  end
end
