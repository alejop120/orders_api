# Orders API

API responsable de la creación y consulta de pedidos.  
Se comunica con el servicio de clientes vía HTTP y emite eventos cuando se crea un pedido.

## Stack

- Ruby 3.3.2
- Rails 7.1.5.2 (API)
- PostgreSQL
- RabbitMQ
- RSpec

## Setup

```bash
bundle install
rails db:create db:migrate


Configurar variables de entorno:

CUSTOMERS_API_URL=http://localhost:3001

Run
rails s -p 3000

Endpoints
Crear orden

POST /orders

{
  "order": {
    "customer_id": 1,
    "product_name": "Producto",
    "quantity": 2,
    "price": 10000,
    "status": "created"
  }
}

Listar órdenes por cliente

GET /orders/index?customer_id=1


Eventos

Cuando un pedido es creado, se publica un evento en RabbitMQ con la información básica del pedido.
Este evento es consumido por el servicio de clientes para actualizar el contador de pedidos.

Tests
bundle exec rspec




Diagrama de arquitectura


+--------------+        HTTP        +------------------+
|              | -----------------> |                  |
|  Orders API  |                    |  Customers API   |
|              | <----------------- |                  |
+--------------+                    +------------------+
        |
        |  publish (order.created)
        v
   +----------------+
   |   RabbitMQ     |
   |  Exchange:     |
   |    orders      |
   +----------------+
        |
        v
 +-------------------+
 |  orders_created   |
 |      Queue        |
 +-------------------+
        |
        v
+---------------------+
|  Customers API      |
| OrderEventsListener |
+---------------------+
