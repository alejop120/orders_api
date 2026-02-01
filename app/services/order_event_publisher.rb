require "bunny"
require "json"

class OrderEventPublisher
  def self.publish(order)
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    exchange = channel.topic("orders", durable: true)

    exchange.publish(
      {
        order_id: order.id,
        customer_id: order.customer_id
      }.to_json,
      routing_key: "order.created"
    )

    connection.close
  end
end
