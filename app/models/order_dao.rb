class OrderDao

  def initialize(conn)
    @conn = conn
  end

  def create (order)
    date = Time.now.to_s(:db)
    db = @conn.open
    db.query("insert into orders
    (total_price, payment_method, shipping_method, clients_id, shipping_status, payment_status, date)
          VALUES('#{order.total_price}',
          '#{order.payment_method}',
          '#{order.shipping_method}',
          '#{order.client_id}', 0, 0, '#{date}')")


  end

  def list
    db = @conn.open
    result_list = db.query('select * from orders', cast: false)
    orders = Array.new()
    result_list.each do |row|
      order = Order.new()

      order.id = row['id']
      order.total_price = row['total_price']
      order.payment_method = row['payment_method']
      order.shipping_method = row['shipping_method']
      order.date = row['date']
      order.payment_status = row['payment_status']
      order.shipping_status = row['shipping_status']
      order.client_id = row['clients_id']

      orders << order
    end
    db.close
    orders
  end

  def get_orders(client_id)
    db = @conn.open
    orders = Array.new()

    result = db.query("SELECT orders.id, orders.total_price,payment_status.payment_status, shipping_status.shipping_status from orders
                        JOIN payment_status
                        ON orders.payment_status = payment_status.id
                        JOIN shipping_status
                        ON orders.shipping_status = shipping_status.id
                        WHERE clients_id = '#{client_id}' ORDER BY orders.id asc;")

    result.each do |row|
      order = Order.new()
      order.id = row['id']
      order.total_price = row['total_price']
      order.payment_status = row['payment_status']
      order.shipping_status = row['shipping_status']
      orders << order
    end
    db.close
    orders
  end

  def get_last_order(id)
    db = @conn.open
    unique_result = db.query("select id from orders where clients_id='#{id}' order by id desc limit 1")
    id = nil

    unique_result.each do |row|
      id = row['id']
    end

    id
  end

  def find(order_id)
    db = @conn.open
    unique_result = db.query("SELECT orders.id, orders.clients_id ,orders.total_price,orders.total_price, orders.payment_method, orders.shipping_method, orders.date ,payment_status.payment_status, shipping_status.shipping_status from orders
JOIN payment_status
ON orders.payment_status = payment_status.id
JOIN shipping_status
ON orders.shipping_status = shipping_status.id
WHERE orders.id = '#{order_id}'")
    order = Order.new()

    unique_result.each do |row|
      order.id = row['id']
      order.total_price = row['total_price']
      order.payment_method = row['payment_method']
      order.shipping_method = row['shipping_method']
      order.payment_status = row['payment_status']
      order.shipping_status = row['shipping_status']
      order.client_id = row['clients_id']
      order.date = row['date']
    end
    order
  end


  def cancel_order(order_id)
    db = @conn.open
    db.query("UPDATE orders SET shipping_status = 3, payment_status = 2 where orders.id = '#{order_id}'")

    db.close
  end

  def set_as_paid(order)
    db = @conn.open
    db.query("update orders set shipping_status = 1, payment_status = 1 where orders.id ='#{order.id}'")
    db.close
  end

  def set_as_delivered(order)
    db = @conn.open
    db.query("update orders set shipping_status = 2 where orders.id = '#{order.id}'")

    db.close
  end

  def set_as_complained(domain)
    db = @conn.open
    db.query("update orders set total_price = '#{domain.total_price}', shipping_status = 4, payment_status = 3 where orders.id = '#{domain.id}'")

    db.close
  end

  def set_voucher_sent(order)
    db = @conn.open

    db.query("update orders set shipping_status = 5, payment_status = 4 where orders.id = '#{order.id}'")

    db.close
  end

end
