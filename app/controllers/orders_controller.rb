class OrdersController < ApplicationController
  def create
    customer = CustomerClient.fetch(order_params[:customer_id])

    return render json: { error: "Customer not found" }, status: :unprocessable_entity unless customer

    order = Order.create!(order_params)

    OrderEventPublisher.publish(order)

    render json: order, status: :created
  end

  def index
    orders = Order.where(customer_id: params[:customer_id])
    render json: orders
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :product_name, :quantity, :price, :status)
  end
end
