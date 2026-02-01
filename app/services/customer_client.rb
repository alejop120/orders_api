class CustomerClient
  BASE_URL = ENV["CUSTOMERS_API_URL"] || "http://localhost:3001"

  def self.fetch(customer_id)
    response = Faraday.get("#{BASE_URL}/customers/#{customer_id}")
    return nil unless response.success?

    JSON.parse(response.body)
  end
end
